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
    func getCellsCount() -> Int
    func getHabit(for indexPath: IndexPath) -> Habit
}

final class HabitViewModel: HabitViewModelType {
    
    private let store = HabitsStore.shared
    var habits: [Habit] = []
    
    func getHabits(completion: @escaping () -> ()) {
        habits = store.habits
        completion()
    }
    
    func getHabit(for indexPath: IndexPath) -> Habit {
        return habits[indexPath.row - 1]
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> HabitCellViewModelType? {
        let habit = habits[indexPath.row - 1]
        return HabitCellViewModel(habit: habit)
    }
    
    func getCellsCount() -> Int {
        return habits.count + 1
    }
}
