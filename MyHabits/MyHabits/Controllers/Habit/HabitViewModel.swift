//
//  HabitViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import Foundation

protocol HabitViewModelType {
    func getHabits()
    func getCellViewModel(for indexPath: IndexPath) -> HabitCellViewModelType?
    func getCellsCount() -> Int
}

final class HabitViewModel: HabitViewModelType {
    
    private let store = HabitsStore.shared
    var habits: [Habit] = []
    
    func getHabits() {
        habits = store.habits
        print(habits, "😅")
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> HabitCellViewModelType? {
        let habit = habits[indexPath.row]
        return HabitCellViewModel(habit: habit)
    }
    
    func getCellsCount() -> Int {
        return habits.count
    }
}
