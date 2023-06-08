//
//  ActionTimeCellViewModel.swift
//  MyHabits
//
//  Created by Kurilova Daria Kirillovna on 07.06.2023.
//

import Foundation

protocol ActionTimeCellViewModelType: class {
    var date: Date { get }
    var isTracked: Bool { get }
    func convertDateToString(_ date: Date) -> String
}

class ActionTimeCellViewModel: ActionTimeCellViewModelType {
    var date: Date
    var isTracked: Bool
    
    init(date: Date, isTracked: Bool) {
        self.date = date
        self.isTracked = isTracked
    }
    
    func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
