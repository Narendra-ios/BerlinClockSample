//
//  BerlinClockCoordinator.swift
//  BerlinClock
//
//  Created by Narendra on 29/05/2021.
//

import UIKit

class BerlinClockCoordinator {
    
    private let viewController: BerlinClockViewController
    private let timerFactory = TimerFactoryImplementation()
    private let berlinClockFormatter: BerlinClockFormatter
    private let calendar = Calendar.init(identifier: .gregorian)
    private var timer: Timer?

    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard
            .instantiateViewController(withIdentifier: "Clock") as! BerlinClockViewController
        viewController.setup(viewModel: BerlinClockViewModel())
        berlinClockFormatter = BerlinClockFormatter(calendar: calendar)
    }
    
    func start() -> UIViewController {
        startTimer()
        return viewController
    }
    
    func updateTime() {
        let colors = berlinClockFormatter.time(for: Date()).map { colorMapper(for: String($0)) }
        viewController.setLampsColor(colors: colors)
    }

    private func colorMapper(for string: String) -> UIColor {
        switch string {
        case BerlinClockFormatter.Style.lightOff: return UIColor.black.withAlphaComponent(0.2)
        case BerlinClockFormatter.Style.lightYellow: return .systemYellow
        case BerlinClockFormatter.Style.lightRed: return .systemRed
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
