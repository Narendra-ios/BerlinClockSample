//
//  BerlinClockFormatterTests.swift
//  BerlinClockTests
//
//  Created by Narendra on 29/05/2021.
//

import XCTest
@testable import BerlinClock

class BerlinClockFormatterTests: XCTestCase {

    let calendar = Calendar.init(identifier: .gregorian)
    var berlinClockFormatter: BerlinClockFormatter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        berlinClockFormatter = BerlinClockFormatter(calendar: calendar)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testSecondsLight() {
        XCTAssertTrue(assertSecondsLight(seconds: [0, 2, 4, 8, 10], expectedResult: "Y"))
        XCTAssertTrue(assertSecondsLight(seconds: [1, 3, 5, 7, 9], expectedResult: "O"))
    }
    
    func testSingleMinuteLights() {
        XCTAssertTrue(assertSingleMinuteLight(minutes: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55], expectedResult: "OOOO"))
        XCTAssertTrue(assertSingleMinuteLight(minutes: [1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56], expectedResult: "YOOO"))
        XCTAssertTrue(assertSingleMinuteLight(minutes: [2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57], expectedResult: "YYOO"))
        XCTAssertTrue(assertSingleMinuteLight(minutes: [3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 53, 58], expectedResult: "YYYO"))
        XCTAssertTrue(assertSingleMinuteLight(minutes: [4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59], expectedResult: "YYYY"))
    }

    func testFiveMinuteLights() {
        XCTAssertTrue(assertFiveMinutesLight(minutes: 0...4, expectedResult: "OOOOOOOOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 5...9, expectedResult: "YOOOOOOOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 10...14, expectedResult: "YYOOOOOOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 15...16, expectedResult: "YYROOOOOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 20...24, expectedResult: "YYRYOOOOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 25...29, expectedResult: "YYRYYOOOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 30...34, expectedResult: "YYRYYROOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 35...39, expectedResult: "YYRYYRYOOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 40...44, expectedResult: "YYRYYRYYOOO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 45...49, expectedResult: "YYRYYRYYROO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 50...54, expectedResult: "YYRYYRYYRYO"))
        XCTAssertTrue(assertFiveMinutesLight(minutes: 55...59, expectedResult: "YYRYYRYYRYY"))
    }
    
    func testSingleHourLights() {
        XCTAssertTrue(assertSingleHoursLight(hours: [0, 5, 10, 15, 20], expectedResult: "OOOO"))
        XCTAssertTrue(assertSingleHoursLight(hours: [1, 6, 11, 16, 21], expectedResult: "ROOO"))
        XCTAssertTrue(assertSingleHoursLight(hours: [2, 7, 12, 17, 22], expectedResult: "RROO"))
        XCTAssertTrue(assertSingleHoursLight(hours: [3, 8, 13, 18, 23], expectedResult: "RRRO"))
        XCTAssertTrue(assertSingleHoursLight(hours: [4, 9, 14, 19], expectedResult: "RRRR"))

    }

    func testFiveHourLights() {
        XCTAssertTrue(assertFiveHoursLight(hours: 0...4, expectedResult: "OOOO"))
        XCTAssertTrue(assertFiveHoursLight(hours: 5...9, expectedResult: "ROOO"))
        XCTAssertTrue(assertFiveHoursLight(hours: 10...14, expectedResult: "RROO"))
        XCTAssertTrue(assertFiveHoursLight(hours: 15...19, expectedResult: "RRRO"))
        XCTAssertTrue(assertFiveHoursLight(hours: 20...23, expectedResult: "RRRR"))

    }
    
    func testTime() {
        XCTAssertEqual(assertTime(second: 00, minute: 00, hour: 00), "YOOOOOOOOOOOOOOOOOOOOOOO")
        XCTAssertEqual(assertTime(second: 59, minute: 59, hour: 23), "ORRRRRRROYYRYYRYYRYYYYYY")
        XCTAssertEqual(assertTime(second: 06, minute: 50, hour: 16), "YRRROROOOYYRYYRYYRYOOOOO")
        XCTAssertEqual(assertTime(second: 01, minute: 37, hour: 11), "ORROOROOOYYRYYRYOOOOYYOO")
    }
    
    private func assertSecondsLight(seconds: [Int], originalDate: Date = Date(), expectedResult: String) -> Bool {
        let dates = seconds.map { calendar.date(bySettingHour: 0, minute: 0, second: $0, of: originalDate)! }
        let results = dates.map { berlinClockFormatter.secondsLight(for: $0) }
        for result in results { return result == expectedResult }
        return false
    }
    
    private func assertSingleMinuteLight(minutes: [Int], originalDate: Date = Date(), expectedResult: String) -> Bool {
        let dates = minutes.map { calendar.date(bySettingHour: 0, minute: $0, second: 0, of: originalDate)! }
        let results = dates.map { berlinClockFormatter.singleMinuteLights(for: $0) }
        for result in results { return result == expectedResult }
        return false
    }
    
    private func assertFiveMinutesLight(minutes: ClosedRange<Int>, originalDate: Date = Date(), expectedResult: String) -> Bool {
        let dates = minutes.map { calendar.date(bySettingHour: 0, minute: $0, second: 0, of: originalDate)! }
        let results = dates.map { berlinClockFormatter.fiveMinuteLights(for: $0) }
        for result in results { return result == expectedResult }
        return false
    }
    
    private func assertSingleHoursLight(hours: [Int], originalDate: Date = Date(), expectedResult: String) -> Bool {
        let dates = hours.map { calendar.date(bySettingHour: $0, minute: 0, second: 0, of: originalDate)! }
        let results = dates.map { berlinClockFormatter.singleHourLights(for: $0) }
        for result in results { return result == expectedResult }
        return false
    }
    
    private func assertFiveHoursLight(hours: ClosedRange<Int>, originalDate: Date = Date(), expectedResult: String) -> Bool {
        let dates = hours.map { calendar.date(bySettingHour: $0, minute: 0, second: 0, of: originalDate)! }
        let results = dates.map { berlinClockFormatter.fiveHourLights(for: $0) }
        for result in results { return result == expectedResult }
        return false
    }
 
    private func assertTime(second: Int, minute: Int, hour: Int, originalDate: Date = Date()) -> String {
        let date = calendar.date(bySettingHour: hour, minute: minute, second: second, of: originalDate)
        return berlinClockFormatter.time(for: date!)
    }
}

