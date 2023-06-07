//
//  ActionTimeViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 03.06.2023.
//

import Foundation

protocol ActionTimeViewModelType {
    var habit: Habit { get }
}

final class ActionTimeViewModel: ActionTimeViewModelType {
    var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
    }
}
