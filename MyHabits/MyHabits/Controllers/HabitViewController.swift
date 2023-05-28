//
//  ViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import UIKit
import PinLayout

class HabitViewController: UIViewController {
    
    private var viewModel: HabitViewModelType?
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        viewModel = HabitViewModel()
        setupUI()
        setupNavigationController()
        setupConstraints()
    }
    
    private func setupUI() {
        tableView.backgroundColor = .blue
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 142
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }
    
    private func setupNavigationController() {

    }
    
    private func setupConstraints() {
        tableView.pin
            .all()
    }
}

extension HabitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HabitCell.id,
            for: indexPath) as? HabitCell
        else { return UITableViewCell() }
        
//        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
//        cell.viewModel = cellViewModel

        return cell
    }
    
    
}

extension HabitViewController: UITableViewDelegate {
    
}
