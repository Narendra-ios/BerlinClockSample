//
//  BerlinClockFormatter.swift
//  BerlinClock
//
//  Created by Narendra on 29/05/2021.
//

import Foundation

final class BerlinClockFormatter {
       
    // MARK: - Constants

    enum ColorCode {
        static let off = "O"
        static let yellow = "Y"
        static let red = "R"
    }
    
    private enum Constants {
        static let totalFiveHourLights = 4
        static let totalSingleHourLights = 4
        static let totalFiveMinuteLights = 11
        static let totalSigleMinuteLights = 4
    }
    
    // MARK: - Private properties

    private let berlinClockManager: BerlinClockManager
    
    // MARK: - Object lifeCycle

    init(calendar: Calendar) {
        berlinClockManager = BerlinClockManager(calendar: calendar)
    }
    
    // MARK: - Internal functions

    func secondsLight(for date: Date) -> String {
        berlinClockManager.secondsLamp(for: date) ?  ColorCode.yellow : ColorCode.off
    }
    
    func singleMinuteLights(for date: Date) -> String {
        calculateLights(total: Constants.totalSigleMinuteLights, iluminated: berlinClockManager.singleMinuteRows(for: date), color: ColorCode.yellow)
    }
    
    func fiveMinuteLights(for date: Date) -> String {
        let minutes = calculateLights(total: Constants.totalFiveMinuteLights, iluminated: berlinClockManager.fiveMinutesRows(for: date), color: ColorCode.yellow)
        return addVisualAid(to: minutes)
    }
    
    func singleHourLights(for date: Date) -> String {
        calculateLights(total: Constants.totalSigleMinuteLights, iluminated: berlinClockManager.singleHourRows(for: date), color: ColorCode.red)
    }
    
    func fiveHourLights(for date: Date) -> String {
        calculateLights(total: Constants.totalSigleMinuteLights, iluminated: berlinClockManager.fiveHourRows(for: date), color: ColorCode.red)
    }
    
    // MARK: - Private functions

    private func calculateLights(total amountOfLights: Int, iluminated: Int, color: String) -> String {
        var lights = ""
        for light in 1...amountOfLights {
            lights += light > iluminated ? ColorCode.off : color
        }
        return lights
    }
    
    private func addVisualAid(to minutes: String) -> String {
        var lights = ""
        for (index, char) in minutes.enumerated() {
            // apply red color for every iluminated 3rd light
            let shouldApplyRed = berlinClockManager.isMultipleOf3(number: index + 1) && String(char) != ColorCode.off
            lights += shouldApplyRed ? ColorCode.red : String(char)
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
