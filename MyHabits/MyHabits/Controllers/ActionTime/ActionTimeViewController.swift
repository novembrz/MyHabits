//
//  ActionTimeViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 03.06.2023.
//

import UIKit
import PinLayout

class ActionTimeViewController: UIViewController {
    
    let viewModel: ActionTimeViewModelType

    private var tableView = UITableView()
    

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
        view.backgroundColor = .systemGray6
        setupUI()
        setupNavigationController()
        setupConstraints()
        viewModel.getDates {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        tableView.register(ActionTimeCell.self, forCellReuseIdentifier: ActionTimeCell.id)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        view.addSubview(tableView)
    }
    
    private func setupNavigationController() {
        navigationItem.title = viewModel.getHabitName()
        navigationController?.navigationBar.tintColor = .systemPurple
        
        let leftButton = UIBarButtonItem(title: .cancelTitle, style: .plain, target: self, action: #selector(cancelButtonTapped))
        let rigthButton = UIBarButtonItem(title: .editTitle, style: .done, target: self, action: #selector(editButtonTapped))
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rigthButton
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupConstraints() {
        tableView.pin
            .all()
    }
}
    
    //MARK: - Actions
    
extension ActionTimeViewController {
    @objc private func cancelButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func editButtonTapped() {
        self.navigationController?.pushViewController(HabitSettingsViewController(), animated: true)
    }
}

//MARK: - UITableViewDataSource

extension ActionTimeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDatesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActionTimeCell.id,
            for: indexPath) as? ActionTimeCell
        else { return UITableViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return .activeTitle
    }
}

//MARK: - Extensions

private extension String {
    static let cancelTitle = "Отменить"
    static let editTitle = "Править"
    static let activeTitle = "Активность"
}
