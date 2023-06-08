//
//  HabitCellViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 28.05.2023.
//

import Foundation

protocol HabitCellViewModelType: class {
    var habit: Habit { get }
}

final class HabitCellViewModel: HabitCellViewModelType {
    var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
}
