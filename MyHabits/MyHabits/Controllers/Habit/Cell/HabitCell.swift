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
    private var checkImageView = UIImageView()
    
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
        
//        checkImageView.image = UIImage(systemName: selected ? "checkmark.circle.fill" : "circle" )?.withRenderingMode(.alwaysTemplate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkImageView.image = nil
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize { //зачем
        return autoSizeThatFits(size, layoutClosure: setupConstraints)
    }
    

    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        taskLabel.font = UIFont.boldSystemFont(ofSize: 20)
        taskLabel.numberOfLines = 2
        taskLabel.text = "f"
        
        dateLabel.textColor = .systemGray2
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.text = "f"
        
        countLabel.textColor = .systemGray
        countLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.text = "Счетчик: "
        
        addSubview(view)
        view.addSubview(taskLabel)
        view.addSubview(dateLabel)
        view.addSubview(countLabel)
        view.addSubview(checkImageView)
    }
    
    private func configure(habit: Habit) {
        taskLabel.text = habit.name
        taskLabel.textColor = habit.color
        
        dateLabel.text = habit.dateString
        
        checkImageView.tintColor = habit.color
        checkImageView.image = UIImage(systemName: habit.isAlreadyTakenToday ? "checkmark.circle.fill" : "circle")?.withRenderingMode(.alwaysTemplate)
    }
    
    private func setupConstraints() {
        view.pin
            .all()
            .marginTop(6)
            .marginBottom(6)
            .marginHorizontal(17)
            .height(130)
            .width(UIScreen.main.bounds.width - 34)
        
        taskLabel.pin
            .top()
            .horizontally()
            .marginVertical(20)
            .marginLeft(17)
            .marginRight(103)
            .sizeToFit(.width)
        
        dateLabel.pin
            .below(of: taskLabel, aligned: .left)
            .right()
            .marginTop(4)
            .marginRight(103)
            .sizeToFit(.width)
        
        countLabel.pin
            .bottom()
            .horizontally()
            .marginHorizontal(17)
            .marginRight(135)
            .marginBottom(20)
            .sizeToFit(.width)
        
        checkImageView.pin
            .vCenter(0)
            .right()
            .marginRight(25)
            .height(38)
            .width(38)
    }
}
