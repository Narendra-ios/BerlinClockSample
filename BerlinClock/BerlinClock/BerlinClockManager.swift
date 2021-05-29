//
//  BerlinClockManager.swift
//  BerlinClock
//
//  Created by Narendra on 29/05/2021.
//

import Foundation

final class BerlinClockManager {
    
    private enum Constants {
        static let sizeofMinuteBlocks = 5
        static let sizeofHourBlocks = 5
    }
    
    private let calendar: Calendar
    
    init(calendar: Calendar) {
        self.calendar = calendar
    }
    
    func secondsLamp(for date: Date) -> Bool {
        seconds(from: date) % 2 == 0
    }
    
    func singleMinuteRows(for date: Date) -> Int {
        minutes(from: date)  % Constants.sizeofMinuteBlocks
    }
    
    func fiveMinutesRows(for date: Date) -> Int {
        minutes(from: date) / Constants.sizeofMinuteBlocks
    }
    
    func singleHourRows(for date: Date) -> Int {
        hours(from: date) % Constants.sizeofHourBlocks
    }
    
    func fiveHourRows(for date: Date) -> Int {
        hours(from: date) / Constants.sizeofHourBlocks
    }
    
    func isMultipleOf3(number: Int) -> Bool {
        number % 3 == 0
    }
}

extension BerlinClockManager {
    
    private func seconds(from date: Date) -> Int {
        calendar.component(.second, from: date)
    }
    
    private func minutes(from date: Date) -> Int {
        calendar.component(.minute, from: date)
    }
    
    private func hours(from date: Date) -> Int {
        calendar.component(.hour, from: date)
    }
}
