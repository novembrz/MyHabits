//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 29.05.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize.height = descriptionLabel.frame.maxY + titleLabel.frame.maxY
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .systemGray6

        titleLabel.text = .title
        titleLabel.font = UIFont.boldSystemFont(ofSize: .titleFontSize)

        descriptionLabel.text = .description
        descriptionLabel.font = UIFont.systemFont(ofSize: .descriptionFontSize)
        descriptionLabel.numberOfLines = .numberOfLines

        scrollView.backgroundColor = .clear

        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = .navigationTitle
    }
    
    private func setupConstraints() {
        scrollView.pin
            .all()
        
        titleLabel.pin
            .top()
            .horizontally()
            .marginTop(.titleTopMargin)
            .marginHorizontal(.titleMarginHorizontal)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: titleLabel, aligned: .left)
            .horizontally()
            .pinEdges()
            .bottom()
            .marginVertical(.descriptionMarginVertical)
            .sizeToFit(.width)
    }
}


//MARK: - Extensions

private extension String {
    static let navigationTitle = "Информация"
    static let title = "Привычка за 21 день"
    static let description = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,с чем еще предстоит серьезно бороться.\n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n\n6. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств."
}

private extension CGFloat {
    static let titleFontSize: CGFloat = 20
    static let titleTopMargin: CGFloat = 21
    static let titleMarginHorizontal: CGFloat = 16
    static let descriptionFontSize: CGFloat = 17
    static let descriptionMarginVertical: CGFloat = 16
}

private extension Int {
    static let numberOfLines = 0
}
