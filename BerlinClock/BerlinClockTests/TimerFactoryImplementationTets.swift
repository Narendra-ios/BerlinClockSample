//
//  TimerFactoryTets.swift
//  BerlinClockTests
//
//  Created by Narendra on 29/05/2021.
//

import XCTest
@testable import BerlinClock

class TimerFactoryImplementationTets: XCTestCase {

    var timerFactory: TimerFactoryImplementation!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        timerFactory = TimerFactoryImplementation()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
       timerFactory = nil
    }

    func testExecuteValidTimer() {
        let timer = timerFactory.execute(block: {}, interval: 10)
        XCTAssertTrue(timer.isValid)
        XCTAssertEqual(timer.timeInterval, 10)
    }

    func testExecuteBlock() {
        var blockFired = false
        let timer = timerFactory.execute(block: {
            blockFired = true
        }, interval: 10)
        timer.fire()
        XCTAssertTrue(blockFired)
    }
    
    func testInvalidateTimer() {
        let timer = timerFactory.execute(block: { }, interval: 10)
        timerFactory.stop(timer: timer)
        XCTAssertFalse(timer.isValid)
    }
}
