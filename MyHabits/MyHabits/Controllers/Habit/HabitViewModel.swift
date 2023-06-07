//
//  HabitViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import Foundation

protocol HabitViewModelType {
    func getHabits(completion: @escaping() -> ())
    func getCellViewModel(for indexPath: IndexPath) -> HabitCellViewModelType?
    //func getActionTimeViewModel(for indexPath: IndexPath) -> ActionTimeViewModelType?
    func getCellsCount() -> Int
    func gethabit(for indexPath: IndexPath) -> Habit
}

final class HabitViewModel: HabitViewModelType {
    
    private let store = HabitsStore.shared
    var habits: [Habit] = []
    
    func getHabits(completion: @escaping() -> ()) {
        habits = store.habits
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> HabitCellViewModelType? {
        let habit = habits[indexPath.row]
        return HabitCellViewModel(habit: habit)
    }
    
//    func getActionTimeViewModel(for indexPath: IndexPath) -> ActionTimeViewModelType? {
//        let habit = habits[indexPath.row]
//        return ActionTimeViewModel(habit: habit)
//    }
    
    func getCellsCount() -> Int {
        return habits.count
    }
    
    func gethabit(for indexPath: IndexPath) -> Habit {
        return habits[indexPath.row]
    }
}
