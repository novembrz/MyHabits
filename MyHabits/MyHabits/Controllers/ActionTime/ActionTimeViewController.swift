//
//  ActionTimeViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 03.06.2023.
//

import UIKit

class ActionTimeViewController: UIViewController {
    
    let viewModel: ActionTimeViewModelType
    
    init(habit: Habit) {
        let vm = ActionTimeViewModel(habit: habit)
        self.viewModel = vm
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    private func setupNavigationController() {
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .systemPurple
        
        let leftButton = UIBarButtonItem(title: .cancelTitle, style: .plain, target: self, action: #selector(cancelButtonTapped))
        let rigthButton = UIBarButtonItem(title: .editTitle, style: .done, target: self, action: #selector(editButtonTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rigthButton
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        self.navigationController?.pushViewController(HabitSettingsViewController(), animated: true)
    }
}

private extension String {
    static let cancelTitle = "Отменить"
    static let editTitle = "Править"
}
