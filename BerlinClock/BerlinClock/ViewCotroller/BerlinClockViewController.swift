//
//  ViewController.swift
//  BerlinClock
//
//  Created by Narendra on 28/05/2021.
//

import UIKit

class BerlinClockViewController: UIViewController {

    @IBOutlet var lamps: [UIView]? = Array(repeating: UIView(), count: 24)

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func setLampsColor(colors: [UIColor]) {
        guard let lamps = lamps else { return }
        UIView.animate(withDuration: 0.3) {
            self.colorize(colors: colors, lamps: lamps)
        }
    }

    private func colorize(colors: [UIColor], lamps: [UIView]) {
        zip(colors, lamps).forEach(generateColor)
    }

    private func generateColor(for color: UIColor, on view: UIView) {
        view.backgroundColor = color
    }
}

extension BerlinClockViewController {
    
    private func style() {
        guard (lamps?.removeFirst()) != nil else { return }
        guard let lamps = lamps else { return }
        roundCorners(views: lamps, cornerRadius: 10)
    }

    private func roundCorners(views: [UIView], cornerRadius: CGFloat) {
        views.forEach { (view) in
            view.layer.cornerRadius = cornerRadius
        }
    }
}
