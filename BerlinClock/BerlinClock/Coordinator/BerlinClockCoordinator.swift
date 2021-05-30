//
//  BerlinClockCoordinator.swift
//  BerlinClock
//
//  Created by Narendra on 29/05/2021.
//

import UIKit

final class BerlinClockCoordinator {
    
    // MARK: - Private properties

    private let viewController: BerlinClockViewController
    private let timerFactory = TimerFactoryImplementation()
    private let berlinClockFormatter: BerlinClockFormatter
    private let calendar = Calendar.init(identifier: .gregorian)
    private var timer: Timer?

    // MARK: - Object lifeCycle

    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard
            .instantiateViewController(withIdentifier: "Clock") as! BerlinClockViewController
        viewController.setup(viewModel: BerlinClockViewModel())
        berlinClockFormatter = BerlinClockFormatter(calendar: calendar)
    }
    
    // MARK: - Internal functions

    func start() -> UIViewController {
        startTimer()
        return viewController
    }
    
    /// convert each charecter from time string into UIColor
    /// ex: "YROY" will be converted into [.systemYellow, .systemRed, .black.withAlphaComponent(0.2),  .systemYellow]
    func updateTime() {
        let colors = berlinClockFormatter.time(for: Date()).map { colorMapper(for: String($0)) }
        viewController.setLampsColor(colors: colors)
    }

    func colorMapper(for string: String) -> UIColor {
        switch string {
        case BerlinClockFormatter.ColorCode.off: return UIColor.black.withAlphaComponent(0.2)
        case BerlinClockFormatter.ColorCode.yellow: return .systemYellow
        case BerlinClockFormatter.ColorCode.red: return .systemRed
        default: return .black
        }
    }
}

extension BerlinClockCoordinator {
    
    func startTimer() {
        timer = timerFactory.execute(block: updateTime, interval: 1)
    }
    
    func stopTimer() {
        guard let timer = timer else { return }
        timerFactory.stop(timer: timer)
    }
}
