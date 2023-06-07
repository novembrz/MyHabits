//
//  ViewController.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import UIKit
import PinLayout

protocol ReloaderDelegate {
    func reloadTableView()
}

class HabitsViewController: UIViewController {
    
    private var viewModel: HabitViewModelType?
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        viewModel = HabitViewModel()

        getData()
        setupUI()
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        tableView.backgroundColor = .systemGray6
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.id)
        tableView.register(ProgressViewCell.self, forCellReuseIdentifier: ProgressViewCell.id)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemPurple
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = .navigationTitle
    }
    
    private func setupConstraints() {
        tableView.pin
            .all()
    }
}

//MARK: - Actions

extension HabitsViewController {
    @objc func addHabit() {
        let vc = HabitSettingsViewController()
        vc.delegate = self
        openController(vc)
    }
    
    private func openController(_ vc: UIViewController) {
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        navigationController?.present(navController, animated: true)
    }
}


//MARK: - ReloaderDelegate

extension HabitsViewController: ReloaderDelegate {
    private func getData() {
        viewModel?.getHabits { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func reloadTableView() {
        getData()
    }
}


//MARK: - UITableViewDataSource

extension HabitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCellsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ProgressViewCell.id,
                    for: indexPath) as? ProgressViewCell
            else { return UITableViewCell() }
            return cell
        } else {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: HabitCell.id,
                    for: indexPath) as? HabitCell,
                let viewModel = viewModel
            else { return UITableViewCell() }
            
            let cellViewModel = viewModel.getCellViewModel(for: indexPath)
            cell.viewModel = cellViewModel
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return .progressRowHeight
        } else {
            return .rowHeight
        }
    }
}

//MARK: - UITableViewDelegate

extension HabitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            guard let viewModel = viewModel else { return }
            let newVC = ActionTimeViewController(habit: viewModel.getHabit(for: indexPath))
            openController(newVC)
        }
    }
}


//MARK: - Extensions

private extension CGFloat {
    static let rowHeight: CGFloat = 142
    static let progressRowHeight: CGFloat = 93
}

private extension String {
    static let navigationTitle = "Сегодня"
}
