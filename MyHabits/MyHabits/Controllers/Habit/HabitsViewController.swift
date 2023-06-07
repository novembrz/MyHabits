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

        getData()
        setupUI()
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func getData() {
        viewModel?.getHabits { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        tableView.backgroundColor = .clear
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.id)
        tableView.separatorStyle = .none
        tableView.rowHeight = .rowHeight
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(progressView)
        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemPurple
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabit))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = .navigationTitle
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

//MARK: - Actions

extension HabitsViewController {
    @objc func addHabit() {
        openController(HabitSettingsViewController())
    }
    
    private func openController(_ vc: UIViewController) {
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .overFullScreen
        navigationController?.present(navController, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension HabitsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getCellsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

//MARK: - UITableViewDelegate

extension HabitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let newVC = ActionTimeViewController(habit: viewModel.gethabit(for: indexPath))
        openController(newVC)
    }
}


//MARK: - Extensions

private extension CGFloat {
    static let rowHeight: CGFloat = 142
}

private extension String {
    static let navigationTitle = "Сегодня"
}
