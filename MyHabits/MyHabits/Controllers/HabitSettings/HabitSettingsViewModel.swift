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
    var timeDate: Date? {get }
    
    func getSelectedTime(date: Date) -> String
    func saveNewHabit(title: String, color: UIColor, date: Date, comp: @escaping () -> ())
    func saveSelectedTime(date: Date)
    func saveSelectedColor(color: UIColor)
}

final class HabitSettingsViewModel: HabitSettingsViewModelType {
    
    var chooseColorHandler: ((UIColor) -> ())?
    var chooseTimeHandler: ((Date) -> ())?
    var timeDate: Date?
    
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
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        comp()
    }
    

}
