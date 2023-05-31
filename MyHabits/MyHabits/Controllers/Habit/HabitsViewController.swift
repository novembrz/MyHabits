//
//  ViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import UIKit
import PinLayout

class HabitsViewController: UIViewController {
    
    private var viewModel: HabitViewModelType?
    private var tableView = UITableView()
    private var progressView = ProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6

        viewModel = HabitViewModel()
        viewModel?.getHabits()

        setupUI()
        setupNavigationBar()
        setupConstraints()
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        tableView.backgroundColor = .clear
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.id)
        tableView.separatorStyle = .none
        tableView.rowHeight = .rowHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        view.addSubview(progressView)
        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .purple
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = .navigationTitle
    }
    
    @objc func addHabit() {
        navigationController?.pushViewController(HabitSettingsViewController(), animated: true)
    }
    
    private func setupConstraints() {
        progressView.pin
            .top()
            .horizontally()
        
        tableView.pin
            .below(of: progressView)
            .horizontally()
            .bottom()
    }
}

//MARK: - UITableViewDataSource

extension HabitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCellsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HabitCell.id,
            for: indexPath) as? HabitCell,
              let viewModel = viewModel
        else { return UITableViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(for: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension HabitsViewController: UITableViewDelegate {
}


//MARK: - Extensions

private extension CGFloat {
    static let rowHeight: CGFloat = 142
}

private extension String {
    static let navigationTitle = "Сегодня"
}
