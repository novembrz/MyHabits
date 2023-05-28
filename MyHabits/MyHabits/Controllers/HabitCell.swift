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
    var viewModel: HabitCellViewModelType?
    
 //   weak var viewModel: HabitCellViewModelType? //{
//        willSet(viewModel) {
//            guard let viewModel = viewModel else { return }
//            taskLabel.text = viewModel.description
//            guard let url = URL(string: viewModel.imageUrl) else { return }
//            photoImageView.sd_setImage(with: url, completed: nil)
//        }
//    }
    
    private var view = UIView()
    private var taskLabel = UILabel()
    private var dateLabel = UILabel()
    private var countLabel = UILabel()
    private var checkImageView = UIImageView()
    
    //MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .red
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkImageView.image = nil
    }

    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        taskLabel.textColor = .purple
        taskLabel.font = UIFont.boldSystemFont(ofSize: 20)
        taskLabel.text = "Task label"
        
        dateLabel.textColor = .systemGray2
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.text = "DATE label"
        
        countLabel.textColor = .systemGray
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.text = "sdfg"
        
        checkImageView.image = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        checkImageView.tintColor = .purple
        
        addSubview(view)
        view.addSubview(taskLabel)
        view.addSubview(dateLabel)
        view.addSubview(countLabel)
        view.addSubview(checkImageView)
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
            .top()
            .horizontally()
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
