//
//  ViewController.swift
//  BerlinClock
//
//  Created by Narendra on 28/05/2021.
//

import UIKit

class BerlinClockViewController: UIViewController {

    @IBOutlet var lamps: [UIView]?
    private var viewModel: BerlinClockViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        self.title = viewModel?.viewTitle
    }
    
    func setup(viewModel: BerlinClockViewModel) {
        self.viewModel = viewModel
    }
    
    func setLampsColor(colors: [UIColor]) {
        guard let lamps = lamps else { return }
        UIView.animate(withDuration: 0.1) {
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
        guard var newLamps = lamps else { return }
        // dont apply corner radius for secons view
        newLamps.removeFirst()
        roundCorners(views: newLamps, cornerRadius: 10)
    }

    private func roundCorners(views: [UIView], cornerRadius: CGFloat) {
        views.forEach { (view) in
            view.layer.cornerRadius = cornerRadius
        }
    }
}
