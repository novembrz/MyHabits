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
    //var viewModel: HabitCellViewModelType?
    
    var viewModel: HabitCellViewModelType? {
        willSet(viewModel) {
            configure()
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
        
        checkImageView.image = UIImage(systemName: selected ? "checkmark.circle.fill" : "circle" )?.withRenderingMode(.alwaysTemplate)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkImageView.image = nil
    }
    
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//        setupConstraints()
//    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize { //зачем
        return autoSizeThatFits(size, layoutClosure: setupConstraints)
    }
    

    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        taskLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateLabel.textColor = .systemGray2
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        
        countLabel.textColor = .systemGray
        countLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.text = "sd"
        
        //checkImageView.image = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        
        addSubview(view)
        view.addSubview(taskLabel)
        view.addSubview(dateLabel)
        view.addSubview(countLabel)
        view.addSubview(checkImageView)
    }
    
    func configure() {
        guard let habbit = viewModel?.habit else { return }

        taskLabel.text = habbit.name
        taskLabel.textColor = habbit.color
        
        dateLabel.text = habbit.dateString
        
        checkImageView.tintColor = habbit.color
    }
    
    private func setupConstraints() {
        view.pin
            .all()
            .marginBottom(12)
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
