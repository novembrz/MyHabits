//
//  ProgressView.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 31.05.2023.
//

import UIKit
import PinLayout

class ProgressViewCell: UITableViewCell {
    
    static let id = "ProgressViewCell"

    private let view = UIView()
    private let titleLabel = UILabel()
    private let progressLabel = UILabel()
    private let progressView = UIProgressView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemGray6
        view.layer.cornerRadius = .radius
        view.backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: .textSize)
        titleLabel.textColor = .systemGray
        titleLabel.text = .title
        
        progressLabel.font = UIFont.boldSystemFont(ofSize: .textSize)
        progressLabel.textColor = .systemGray
        progressLabel.text = "\(HabitsStore.shared.todayProgress*10)%"
        progressLabel.textAlignment = .right
        
        progressView.progressTintColor = .systemPurple
        progressView.progress = HabitsStore.shared.todayProgress
        
        addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(progressLabel)
        view.addSubview(progressView)
    }
    
    private func setupConstraints() {
        view.pin
            .all()
            .marginHorizontal(.cellMarginHorizontal)
            .marginTop(.cellMarginTop)
            .marginBottom(.cellMarginBottom)
            .width(.cellWidth)
            .height(.cellHeight)
        
        titleLabel.pin
            .top()
            .left()
            .marginTop(.titleMarginTop)
            .marginLeft(.margin)
            .sizeToFit(.widthFlexible)
        
        progressLabel.pin
            .after(of: titleLabel, aligned: .top)
            .right()
            .marginRight(.margin)
            .marginLeft(.titleMarginLeft)
            .sizeToFit(.width)
        
        progressView.pin
            .below(of: [titleLabel, progressView], aligned: .left)
            .horizontally()
            .bottom()
            .marginTop(.progressMarginTop)
            .marginHorizontal(.margin)
            .marginBottom(.progressMarginBottom)
            .height(.progressHeight)
    }
}

//MARK: - Extensions

private extension String {
    static let title = "Всё получится!"
}

private extension CGFloat {
    static let margin: CGFloat = 12
    static let textSize: CGFloat = 13
    static let radius: CGFloat = 8
    
    static let cellWidth: CGFloat = UIScreen.main.bounds.size.width - 17*2
    static let cellMarginTop: CGFloat = 21
    static let cellMarginHorizontal: CGFloat = 17
    static let cellMarginBottom: CGFloat = 12
    static let cellHeight: CGFloat = 60
    
    static let titleMarginTop: CGFloat = 10
    static let titleMarginLeft: CGFloat = 8
    
    static let progressMarginTop: CGFloat = 10
    static let progressMarginBottom: CGFloat = 15
    static let progressHeight: CGFloat = 7
}
