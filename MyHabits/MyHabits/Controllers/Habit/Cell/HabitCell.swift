//
//  HabitCell.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import UIKit
import PinLayout

class HabitCell: UITableViewCell {
    
    static let id = "HabitCell"
    
    weak var viewModel: HabitCellViewModelType? {
        willSet(viewModel) {
            guard let habit = viewModel?.habit else { return }
            configure(habit: habit)
        }
    }
    
    private var view = UIView()
    private var taskLabel = UILabel()
    private var dateLabel = UILabel()
    private var countLabel = UILabel()
    private var checkButton = UIButton()
    
    //MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewModel?.checkHabit()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return autoSizeThatFits(size, layoutClosure: setupConstraints)
    }
    

    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = .cornerRadius
        
        taskLabel.font = UIFont.boldSystemFont(ofSize: .taskTextSize)
        taskLabel.numberOfLines = .numberOfLines
        taskLabel.text = "f"
        
        dateLabel.textColor = .systemGray2
        dateLabel.font = UIFont.systemFont(ofSize: .dateTextSize)
        dateLabel.text = "f"
        
        countLabel.textColor = .systemGray
        countLabel.font = UIFont.systemFont(ofSize: .countTextSize)
        countLabel.text = .countTitle
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        addSubview(view)
        view.addSubview(taskLabel)
        view.addSubview(dateLabel)
        view.addSubview(countLabel)
        view.addSubview(checkButton)
    }
    
    private func configure(habit: Habit) {
        taskLabel.text = habit.name
        taskLabel.textColor = habit.color
        
        dateLabel.text = habit.dateString
        
        checkButton.tintColor = habit.color
        checkButton.setBackgroundImage( UIImage(systemName: habit.isAlreadyTakenToday ? .checkmarkImageName : .circleImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @objc func checkButtonTapped() {
        viewModel?.checkHabit()
    }
    
    private func setupConstraints() {
        view.pin
            .all()
            .marginVertical(.viewMarginVertical)
            .marginHorizontal(.marginHorizontal)
            .height(.viewHeight)
            .width(UIScreen.main.bounds.width - .marginHorizontal*2)
        
        taskLabel.pin
            .top()
            .horizontally()
            .marginVertical(.taskMarginVertical)
            .marginLeft(.marginHorizontal)
            .marginRight(.marginRight)
            .sizeToFit(.width)
        
        dateLabel.pin
            .below(of: taskLabel, aligned: .left)
            .right()
            .marginTop(.dateMarginTop)
            .marginRight(.marginRight)
            .sizeToFit(.width)
        
        countLabel.pin
            .bottom()
            .horizontally()
            .marginHorizontal(.marginHorizontal)
            .marginRight(.marginRight)
            .marginBottom(.countMarginBottom)
            .sizeToFit(.width)
        
        checkButton.pin
            .after(of: [taskLabel, dateLabel, countLabel])
            .vCenter(0)
            .right()
            .marginLeft(.checkMarginLeft)
            .marginRight(.checkMarginRight)
            .height(.imageSize)
            .width(.imageSize)
    }
}

//MARK: - Extensions

private extension String {
    static let countTitle = "Счетчик: "
    static let checkmarkImageName = "checkmark.circle.fill"
    static let circleImageName = "circle"
}

private extension Int {
    static let numberOfLines = 2
}

private extension CGFloat {
    static let taskTextSize: CGFloat = 20
    static let dateTextSize: CGFloat = 12
    static let countTextSize: CGFloat = 13
    
    static let cornerRadius: CGFloat = 8
    static let marginHorizontal: CGFloat = 17
    static let marginRight: CGFloat = 103
    
    static let viewMarginVertical: CGFloat = 6
    static let viewHeight: CGFloat = 130
    
    static let taskMarginVertical: CGFloat = 20
    
    static let dateMarginTop: CGFloat = 4
    static let countMarginBottom: CGFloat = 20
    
    static let checkMarginLeft: CGFloat = 40
    static let checkMarginRight: CGFloat = 25
    static let imageSize: CGFloat = 38
}
