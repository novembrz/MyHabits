//
//  HabitSettingsViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 02.06.2023.
//

import Foundation
import UIKit

protocol HabitSettingsViewModelType {
    var chooseColorHandler: ((UIColor) -> ())? { get set }
    var chooseTimeHandler: ((Date) -> ())? { get set }
    var timeDate: Date? { get }
    var habit: Habit? { get }
    
    func getHabitName() -> String
    func getSelectedTime(date: Date) -> String
    func saveNewHabit(title: String, color: UIColor, date: Date, comp: @escaping () -> ())
    func saveSelectedTime(date: Date)
    func saveSelectedColor(color: UIColor)
    //func editHabit(comp: @escaping () -> ())
    func editHabit(title: String, color: UIColor, date: Date, comp: @escaping () -> ())
    func deleteHabit(comp: @escaping () -> ())
}

final class HabitSettingsViewModel: HabitSettingsViewModelType {
    
    var chooseColorHandler: ((UIColor) -> ())?
    var chooseTimeHandler: ((Date) -> ())?
    var timeDate: Date?
    
    var habit: Habit?
    
    private let store = HabitsStore.shared
    
    init(habit: Habit?) {
        self.habit = habit
    }
    
    func getHabitName() -> String {
        return habit?.name ?? ""
    }
    
    func getSelectedTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func saveSelectedColor(color: UIColor) {
        chooseColorHandler?(color)
    }
    
    func saveSelectedTime(date: Date) {
        timeDate = date
        chooseTimeHandler?(date)
    }
    
    func saveNewHabit(title: String, color: UIColor, date: Date, comp: @escaping () -> ()) {
        let newHabit = Habit(name: title, date: date, color: color)
        store.habits.append(newHabit)
        comp()
    }
    
    func editHabit(title: String, color: UIColor, date: Date, comp: @escaping () -> ()) {
        guard let habit = habit,
              let index = store.habits.firstIndex(of: habit)
        else { return }
        
        store.habits[index].name = title
        store.habits[index].color = color
        store.habits[index].date = date
        comp()
    }
    
    func deleteHabit(comp: @escaping () -> ()) {
        guard let habit = habit,
              let index = store.habits.firstIndex(of: habit)
        else { return }
        
        store.habits.remove(at: index)
        comp()
    }
}
