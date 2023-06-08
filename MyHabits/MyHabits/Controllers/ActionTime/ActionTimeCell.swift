//
//  ActionTimeCell.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 07.06.2023.
//

import UIKit
import PinLayout

class ActionTimeCell: UITableViewCell {
    
    static let id = "ActionTimeCell"
    
    weak var viewModel: ActionTimeCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            configure(for: viewModel.convertDateToString(viewModel.date), isTracked: viewModel.isTracked)
        }
    }
    
    private var titleLabel = UILabel()
    private var checkImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        titleLabel.text = "f"
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        addSubview(titleLabel)
    }
    
    private func configure(for date: String, isTracked: Bool) {
        titleLabel.text = date
        if isTracked {
            checkImageView.image = UIImage(systemName: "check")?.withTintColor(.systemPurple)
            addSubview(checkImageView)
        }
    }
    
    private func setupConstraints() {
        titleLabel.pin
            .vertically()
            .left()
            .marginVertical(11)
            .marginHorizontal(16)
            .width(150)
        
        checkImageView.pin
            .below(of: titleLabel, aligned: .center)
            .vertically()
            .right()
            .width(26)
    }
}
