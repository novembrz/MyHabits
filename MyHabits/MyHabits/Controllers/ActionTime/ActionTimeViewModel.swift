//
//  ActionTimeViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 03.06.2023.
//

import Foundation

protocol ActionTimeViewModelType {
    var habit: Habit { get }
    func getHabitName() -> String
    func getDates(comp: @escaping () -> ())
    func isTracked(date: Date) -> Bool
    func getDatesCount() -> Int
    func getCellViewModel(for indexPath: IndexPath) -> ActionTimeCellViewModelType?
}

final class ActionTimeViewModel: ActionTimeViewModelType {
    var habit: Habit
    var dates: [Date] = []
    
    init(habit: Habit) {
        self.habit = habit
    }
    
    func getHabitName() -> String {
        return habit.name
    }
    
    func getDates(comp: @escaping () -> ()) {
        dates = HabitsStore.shared.dates
        comp()
    }
    
    func isTracked(date: Date) -> Bool {
        return HabitsStore.shared.habit(habit, isTrackedIn: date)
    }
    
    func getDatesCount() -> Int {
        return dates.count
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> ActionTimeCellViewModelType? {
        let date = dates[indexPath.row]
        return ActionTimeCellViewModel(date: date, isTracked: isTracked(date: date))
    }
}
