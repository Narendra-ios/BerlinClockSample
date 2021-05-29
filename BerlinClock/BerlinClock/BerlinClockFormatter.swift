//
//  BerlinClockFormatter.swift
//  BerlinClock
//
//  Created by Narendra on 29/05/2021.
//

import Foundation

class BerlinClockFormatter {
        
    private let berlinClockManager: BerlinClockManager
    
    init(calendar: Calendar) {
        berlinClockManager = BerlinClockManager(calendar: calendar)
    }
    
    enum Style {
        static let lightOff = "O"
        static let lightYellow = "Y"
        static let lightRed = "R"
    }
    
    private enum Constants {
        static let totalFiveHourLights = 4
        static let totalSingleHourLights = 4
        static let totalFiveMinuteLights = 11
        static let totalSigleMinuteLights = 4
    }
    
    func secondsLight(for date: Date) -> String {
        berlinClockManager.secondsLamp(for: date) ?  Style.lightYellow : Style.lightOff
    }
    
    func singleMinuteLights(for date: Date) -> String {
        calculateLights(total: Constants.totalSigleMinuteLights, iluminated: berlinClockManager.singleMinuteRows(for: date), color: Style.lightYellow)
    }
    
    func fiveMinuteLights(for date: Date) -> String {
        let minutes = calculateLights(total: Constants.totalFiveMinuteLights, iluminated: berlinClockManager.fiveMinutesRows(for: date), color: Style.lightYellow)
        return addVisualAid(to: minutes)
    }
    
    func singleHourLights(for date: Date) -> String {
        calculateLights(total: Constants.totalSigleMinuteLights, iluminated: berlinClockManager.singleHourRows(for: date), color: Style.lightRed)
    }
    
    func fiveHourLights(for date: Date) -> String {
        calculateLights(total: Constants.totalSigleMinuteLights, iluminated: berlinClockManager.fiveHourRows(for: date), color: Style.lightRed)
    }
    
    private func calculateLights(total amountOfLights: Int, iluminated: Int, color: String) -> String {
        var lights = ""
        for light in 1...amountOfLights {
            lights += light > iluminated ? Style.lightOff : color
        }
        return lights
    }
    
    private func addVisualAid(to minutes: String) -> String {
        var lights = ""
        for (index, char) in minutes.enumerated() {
            // apply red color for every iluminated 3rd light
            let shouldApplyRed = berlinClockManager.isMultipleOf3(number: index + 1) && String(char) != Style.lightOff
            lights += shouldApplyRed ? Style.lightRed : String(char)
        }
        return lights
    }
}

extension BerlinClockFormatter {
    func time(for date: Date) -> String {
        return [
            secondsLight(for: date),
            fiveHourLights(for: date),
            singleHourLights(for: date),
            fiveMinuteLights(for: date),
            singleMinuteLights(for: date)
        ].joined()
    }
}
