//
//  HabitSettingsViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 29.05.2023.
//

import UIKit
import PinLayout

class HabitSettingsViewController: UIViewController {
    
    private var viewModel: HabitSettingsViewModelType?
    
    private let titleLabel = UILabel()
    private let titleTextField = UITextField()
    private let colorLabel = UILabel()
    private let colorButton = UIButton()
    private let timeLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let chooseTimeLabel = UILabel()
    private let timePicker = UIDatePicker()
    
    private var titleStackView = UIStackView()
    private var colorStackView = UIStackView()
    private var timeStackView = UIStackView()
    private var descriptionStackView = UIStackView()
    private var stackView = UIStackView()
    
    var time = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HabitSettingsViewModel()

        chooseTime()
        chooseColor()
        setupUI()
        setupStackViews()
        setupNavigationController()
        setupConstraints()
    }
    
    //MARK: - setupUI
    
    private func chooseTime() {
        viewModel?.chooseTimeHandler = { [weak self] date in
            let text = self?.viewModel?.getSelectedTime(date: date)
            self?.chooseTimeLabel.text = text
        }
    }
    
    private func chooseColor() {
        viewModel?.chooseColorHandler = { [weak self] color in
            self?.chooseTimeLabel.textColor = color
            self?.colorButton.tintColor = color
            self?.navigationController?.navigationBar.tintColor = color
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        titleLabel.text = .nameTitle.uppercased()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        titleTextField.placeholder = .placeholder
        
        colorLabel.text = .colorTitle.uppercased()
        colorLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        colorButton.setImage(UIImage(systemName: .buttonImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        colorButton.tintColor = .systemPurple
        colorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        
        timeLabel.text = .timeTitle.uppercased()
        timeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        descriptionLabel.text = .descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        
        chooseTimeLabel.font = UIFont.systemFont(ofSize: 17)
        chooseTimeLabel.textColor = .systemPurple
        chooseTimeLabel.textAlignment = .left
        
        timePicker.addTarget(self, action: #selector(timePickerChanged(picker:)), for: .valueChanged)
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
    }
    
    private func setupStackViews() {
        descriptionStackView = createStackView(spacing: 5,
                                               axis: .horizontal,
                                               distribution: .fillEqually,
                                               views: [descriptionLabel, chooseTimeLabel])
        
        titleStackView = createStackView(views: [titleLabel, titleTextField])
        colorStackView = createStackView(views: [colorLabel, colorButton])
        timeStackView = createStackView(views: [timeLabel, descriptionStackView, timePicker])
        
        stackView = createStackView(spacing: 15,
                                    distribution: .fill,
                                    views: [titleStackView, colorStackView, timeStackView])
        
        view.addSubview(stackView)
    }
    
    private func createStackView(
        spacing: CGFloat = 7,
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution:  UIStackView.Distribution = .fillProportionally,
        views: [UIView]) -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: views)
            stackView.axis = axis
            stackView.spacing = spacing
            stackView.distribution = distribution
            stackView.alignment = .leading
            return stackView
    }
    
    private func setupNavigationController() {
        navigationItem.title = .navigationTitle
        navigationController?.navigationBar.tintColor = .systemPurple
        
        let leftButton = UIBarButtonItem(title: .cancelTitle, style: .plain, target: self, action: #selector(cancelButtonTapped))
        let rigthButton = UIBarButtonItem(title: .saveTitle, style: .done, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rigthButton
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        stackView.pin
            .top()
            .horizontally()
            .marginTop(99)
            .marginHorizontal(16)
            .height(500)
        
        titleTextField.pin
            .height(22)
        
        colorButton.pin
            .width(30)
            .height(30)
    }
}

//MARK: - Actions

private extension HabitSettingsViewController {
    
    @objc private func timePickerChanged(picker: UIDatePicker) {
        if picker.isEqual(self.timePicker) {
            viewModel?.saveSelectedTime(date: picker.date)
        }
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        if let text = titleTextField.text, !text.isEmpty {
            viewModel?.saveNewHabit(title: text, color: colorButton.tintColor, date: timePicker.date) {
                self.navigationController?.dismiss(animated: true)
            }
        }
    }
    
    @objc private func colorButtonTapped() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
}


//MARK: - Delegate

extension HabitSettingsViewController: UITextFieldDelegate {
    override class func didChangeValue(forKey key: String) {
        
    }
}

extension HabitSettingsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        viewModel?.saveSelectedColor(color: color)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let color = viewController.selectedColor
        viewModel?.saveSelectedColor(color: color)
    }
}

//MARK: - Extension

private extension String {
    static let navigationTitle = "Создать"
    static let nameTitle = "Название"
    static let colorTitle = "Цвет"
    static let timeTitle = "Время"
    static let placeholder = "Бегать по утрам, спать 8 часов и т.п."
    static let descriptionText = "Каждый день в "
    static let buttonImageName = "circle.fill"
    static var currentTimeText = ""
    static let cancelTitle = "Отменить"
    static let saveTitle = "Сохранить"
}

