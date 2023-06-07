//
//  ProgressView.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 31.05.2023.
//

import UIKit
import PinLayout

class ProgressView: UIView {

    private let view = UIView()
    private let titleLabel = UILabel()
    private let progressLabel = UILabel()
    private let progressView = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBackground
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 13)
        titleLabel.textColor = .systemGray
        titleLabel.text = "Всё получится!"
        
        progressLabel.font = UIFont.boldSystemFont(ofSize: 13)
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
            .marginTop(166)
            .marginHorizontal(17)
            .width(UIScreen.main.bounds.size.width - 17*2)
            .height(60)
        
        titleLabel.pin
            .top()
            .left()
            .marginTop(10)
            .marginLeft(12)
            .sizeToFit(.widthFlexible)
        
        progressLabel.pin
            .after(of: titleLabel, aligned: .top)
            .right()
            .marginRight(12)
            .marginLeft(8)
            .sizeToFit(.width)
        
        progressView.pin
            .below(of: [titleLabel, progressView], aligned: .left)
            .horizontally()
            .bottom()
            .marginTop(10)
            .marginHorizontal(12)
            .marginBottom(15)
            .height(7)
    }
}
