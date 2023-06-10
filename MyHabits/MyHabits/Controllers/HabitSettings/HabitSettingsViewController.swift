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
    private let deleteButton = UIButton()
    
    private var titleStackView = UIStackView()
    private var colorStackView = UIStackView()
    private var timeStackView = UIStackView()
    private var descriptionStackView = UIStackView()
    private var stackView = UIStackView()
    
    var delegate: ReloaderDelegate?
    
    init(habit: Habit? = nil) {
        self.viewModel = HabitSettingsViewModel(habit: habit)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        titleLabel.font = UIFont.boldSystemFont(ofSize: .smallTextSize)
        
        titleTextField.placeholder = .placeholder
        
        colorLabel.text = .colorTitle.uppercased()
        colorLabel.font = UIFont.boldSystemFont(ofSize: .smallTextSize)
        
        colorButton.setImage(UIImage(systemName: .buttonImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        colorButton.tintColor = .systemPurple
        colorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        
        timeLabel.text = .timeTitle.uppercased()
        timeLabel.font = UIFont.boldSystemFont(ofSize: .smallTextSize)
        
        descriptionLabel.text = .descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: .bigTextSize)
        
        chooseTimeLabel.font = UIFont.systemFont(ofSize: .bigTextSize)
        chooseTimeLabel.textColor = .systemPurple
        chooseTimeLabel.textAlignment = .left
        
        timePicker.addTarget(self, action: #selector(timePickerChanged(picker:)), for: .valueChanged)
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        deleteButton.setTitle(.deleteHabitTitle, for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTaped), for: .touchUpInside)
        
        addInformation()
    }
    
    private func addInformation() {
        if let habit = viewModel?.habit {
            colorButton.tintColor = habit.color
            titleTextField.text = habit.name
            timePicker.date = habit.date
            let text = viewModel?.getSelectedTime(date: habit.date)
            chooseTimeLabel.text = text
            
            view.addSubview(deleteButton)
        }
    }
    
    private func setupStackViews() {
        descriptionStackView = createStackView(spacing: .itemSpacing,
                                               axis: .horizontal,
                                               distribution: .fillEqually,
                                               views: [descriptionLabel, chooseTimeLabel])
        
        titleStackView = createStackView(views: [titleLabel, titleTextField])
        colorStackView = createStackView(views: [colorLabel, colorButton])
        timeStackView = createStackView(views: [timeLabel, descriptionStackView, timePicker])
        
        stackView = createStackView(spacing: .stackSpacing,
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
    
    private func createAlert() {
        guard let viewModel = viewModel else { return }
        
        let alert = UIAlertController(
            title: .deleteHabitTitle,
            message: .deleteDescription + viewModel.getHabitName() + "?",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: .cancelTitle, style: .cancel)
        let deleteAction = UIAlertAction(title: .deleteTitle, style: .destructive) { action in
            viewModel.deleteHabit {
                self.popViewController()
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        stackView.pin
            .top()
            .horizontally()
            .marginTop(.stackMarginTop)
            .marginHorizontal(.stackMarginHorizontal)
            .height(.stackHeight)
        
        titleTextField.pin
            .height(.titleHeight)
        
        colorButton.pin
            .width(.colorButtonSize)
            .height(.colorButtonSize)
        
        deleteButton.pin
            .below(of: stackView)
            .horizontally()
            .bottom()
            .marginHorizontal(.deleteMarginHorizontal)
            .marginTop(.deleteMarginTop)
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
        if viewModel?.habit != nil {
            if let text = titleTextField.text, !text.isEmpty {
                viewModel?.editHabit(title: text, color: colorButton.tintColor, date: timePicker.date) {
                    self.popViewController()
                }
            }
        } else {
            if let text = titleTextField.text, !text.isEmpty {
                viewModel?.saveNewHabit(title: text, color: colorButton.tintColor, date: timePicker.date) {
                    self.popViewController()
                }
            }
        }
    }
    
    private func popViewController() {
        delegate?.reloadTableView()
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func colorButtonTapped() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    @objc private func deleteButtonTaped() {
        createAlert()
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
    
    static let deleteHabitTitle = "Удалить привычку"
    static let deleteDescription = "Вы хотите удалить привычку "
    static let deleteTitle = "Удалить"
}

private extension CGFloat {
    static let smallTextSize: CGFloat = 13
    static let bigTextSize: CGFloat = 17
    static let itemSpacing: CGFloat = 5
    static let stackSpacing: CGFloat = 15
    
    static let stackMarginTop: CGFloat = 99
    static let stackMarginHorizontal: CGFloat = 16
    static let stackHeight: CGFloat = 500
    
    static let titleHeight: CGFloat = 22
    
    static let colorButtonSize: CGFloat = 30
    
    static let deleteMarginHorizontal: CGFloat = 110
    static let deleteMarginTop: CGFloat = 100
}
