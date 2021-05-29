//
//  BerlinClockManagerTests.swift
//  BerlinClockTests
//
//  Created by Narendra on 29/05/2021.
//

import XCTest
@testable import BerlinClock

class BerlinClockManagerTests: XCTestCase {

    let calendar = Calendar.init(identifier: .gregorian)
    var berlinClockManager: BerlinClockManager!
    var dateFor_00_00_00:Date!
    var dateFor_01_01_01:Date!
    var dateFor_02_02_02:Date!
    var dateFor_03_03_03:Date!
    var dateFor_04_04_04:Date!
    var dateFor_11_11_11:Date!
    var dateFor_15_15_15:Date!
    var dateFor_17_17_17:Date!
    var dateFor_23_45_45:Date!
    var dateFor_23_50_50:Date!
    var dateFor_23_55_55:Date!
    var dateFor_23_59_59:Date!


    override func setUpWithError() throws {
        try super.setUpWithError()
        berlinClockManager = BerlinClockManager(calendar: calendar)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dateFor_00_00_00 = formatter.date(from: "1972-04-30 00:00:00")
        dateFor_01_01_01 = formatter.date(from: "1972-04-30 01:01:01")
        dateFor_02_02_02 = formatter.date(from: "1972-04-30 02:02:02")
        dateFor_03_03_03 = formatter.date(from: "1972-04-30 03:03:03")
        dateFor_04_04_04 = formatter.date(from: "1972-04-30 04:04:04")
        dateFor_11_11_11 = formatter.date(from: "1972-04-30 11:11:11")
        dateFor_15_15_15 = formatter.date(from: "1972-04-30 15:15:15")
        dateFor_17_17_17 = formatter.date(from: "1972-04-30 17:17:17")
        dateFor_23_45_45 = formatter.date(from: "1972-04-30 23:45:45")
        dateFor_23_50_50 = formatter.date(from: "1972-04-30 23:50:50")
        dateFor_23_55_55 = formatter.date(from: "1972-04-30 23:55:55")
        dateFor_23_59_59 = formatter.date(from: "1972-04-30 23:59:59")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        berlinClockManager = nil
        dateFor_00_00_00 = nil
        dateFor_01_01_01 = nil
        dateFor_02_02_02 = nil
        dateFor_03_03_03 = nil
        dateFor_04_04_04 = nil
        dateFor_11_11_11 = nil
        dateFor_15_15_15 = nil
        dateFor_17_17_17 = nil
        dateFor_23_45_45 = nil
        dateFor_23_50_50 = nil
        dateFor_23_55_55 = nil
        dateFor_23_59_59 = nil
    }

    func testSecondsLamp() {
        XCTAssertTrue(berlinClockManager.secondsLamp(for: dateFor_00_00_00))
        XCTAssertFalse(berlinClockManager.secondsLamp(for: dateFor_01_01_01))
        XCTAssertTrue(berlinClockManager.secondsLamp(for: dateFor_02_02_02))
        XCTAssertFalse(berlinClockManager.secondsLamp(for: dateFor_03_03_03))
    }
    
    func testSingleMinuteRows() {
        XCTAssertEqual(berlinClockManager.singleMinuteRows(for: dateFor_00_00_00), 0)
        XCTAssertEqual(berlinClockManager.singleMinuteRows(for: dateFor_01_01_01), 1)
        XCTAssertEqual(berlinClockManager.singleMinuteRows(for: dateFor_02_02_02), 2)
        XCTAssertEqual(berlinClockManager.singleMinuteRows(for: dateFor_03_03_03), 3)
    }
    
    func testfFiveMinutesRows() {
        XCTAssertEqual(berlinClockManager.fiveMinutesRows(for: dateFor_00_00_00), 0)
        XCTAssertEqual(berlinClockManager.fiveMinutesRows(for: dateFor_15_15_15), 3)
        XCTAssertEqual(berlinClockManager.fiveMinutesRows(for: dateFor_23_45_45), 9)
        XCTAssertEqual(berlinClockManager.fiveMinutesRows(for: dateFor_23_50_50), 10)
        XCTAssertEqual(berlinClockManager.fiveMinutesRows(for: dateFor_23_55_55), 11)
    }
    
    func testSingleHourRows() {
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_00_00_00), 0)
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_01_01_01), 1)
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_02_02_02), 2)
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_03_03_03), 3)
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_04_04_04), 4)
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_17_17_17), 2)
        XCTAssertEqual(berlinClockManager.singleHourRows(for: dateFor_23_59_59), 3)

    }
    
    func testFiveHourRows() {
        XCTAssertEqual(berlinClockManager.fiveHourRows(for: dateFor_00_00_00), 0)
        XCTAssertEqual(berlinClockManager.fiveHourRows(for: dateFor_11_11_11), 2)
        XCTAssertEqual(berlinClockManager.fiveHourRows(for: dateFor_17_17_17), 3)
        XCTAssertEqual(berlinClockManager.fiveHourRows(for: dateFor_23_59_59), 4)
    }
    
    func testIsMultipleOf3() {
        XCTAssertTrue(berlinClockManager.isMultipleOf3(number: 6))
        XCTAssertFalse(berlinClockManager.isMultipleOf3(number: 8))
        XCTAssertTrue(berlinClockManager.isMultipleOf3(number: 9))
        XCTAssertFalse(berlinClockManager.isMultipleOf3(number: 14))
    }
}
