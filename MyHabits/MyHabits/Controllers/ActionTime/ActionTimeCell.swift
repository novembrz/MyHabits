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
    
    //MARK: - setupUI
    
    private func setupUI() {
        backgroundColor = .systemBackground
        titleLabel.text = "f"
        titleLabel.font = UIFont.systemFont(ofSize: .textSize)
        addSubview(titleLabel)
    }
    
    private func configure(for date: String, isTracked: Bool) {
        titleLabel.text = date
        if isTracked {
            checkImageView.image = UIImage(systemName: .imageName)?.withTintColor(.systemPurple)
            addSubview(checkImageView)
        }
    }
    
    private func setupConstraints() {
        titleLabel.pin
            .vertically()
            .left()
            .marginVertical(.titleMarginVertical)
            .marginHorizontal(.titleMarginHorizontal)
            .width(.titleWidth)
        
        checkImageView.pin
            .below(of: titleLabel, aligned: .center)
            .vertically()
            .right()
            .width(.imageWidth)
    }
}

//MARK: - Extensions

private extension CGFloat {
    static let titleMarginVertical: CGFloat = 11
    static let titleMarginHorizontal: CGFloat = 16
    static let titleWidth: CGFloat = 150
    static let imageWidth: CGFloat = 26
    static let textSize: CGFloat = 17
}

private extension String {
    static let imageName = "check"
}
