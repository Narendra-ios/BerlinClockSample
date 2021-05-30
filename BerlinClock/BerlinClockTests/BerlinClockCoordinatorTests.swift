//
//  BerlinClockCoordinatorTests.swift
//  BerlinClockTests
//
//  Created by Narendra on 30/05/2021.
//

import XCTest
@testable import BerlinClock

class BerlinClockCoordinatorTests: XCTestCase {

    private var coordinator: BerlinClockCoordinator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coordinator = BerlinClockCoordinator()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        coordinator = nil
    }

    func testStartMethod() {
        let viewController = coordinator.start()
        XCTAssert(type(of: viewController) == BerlinClockViewController.self)
    }

    func testColorMapper() {
        XCTAssertEqual(coordinator.colorMapper(for: "O"), UIColor.black.withAlphaComponent(0.2))
        XCTAssertEqual(coordinator.colorMapper(for: "Y"), UIColor.systemYellow)
        XCTAssertEqual(coordinator.colorMapper(for: "R"), UIColor.systemRed)
        XCTAssertEqual(coordinator.colorMapper(for: "W"), UIColor.black)
    }
}
