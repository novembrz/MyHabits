//
//  HabitCellViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import Foundation

protocol HabitCellViewModelType: class {
    var habit: Habit { get }
    func checkHabit()
}

final class HabitCellViewModel: HabitCellViewModelType {
    var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    func checkHabit() {
        let store = HabitsStore.shared
        store.track(habit)
    }
}
