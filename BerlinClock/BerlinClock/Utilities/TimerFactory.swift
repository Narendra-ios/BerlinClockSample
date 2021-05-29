//
//  TimerFactory.swift
//  BerlinClock
//
//  Created by Narendra on 29/05/2021.
//

import Foundation

protocol TimerFactory {
    func execute(block: @escaping () -> Void, interval: TimeInterval) -> Timer
    func stop(timer: Timer)
}

struct TimerFactoryImplementation: TimerFactory {
    init() {}
    
    func execute(block: @escaping () -> Void, interval: TimeInterval = 1) -> Timer {
        return Timer.scheduledTimer(withTimeInterval: interval, repeats: true,
            block: { _ in
                block()
            }
        )
    }

    func stop(timer: Timer) {
        timer.invalidate()
    }
}
