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

        // Do any additional setup after loading the view.
    }
}

extension BerlinClockViewController {
    
    private func style() {
        guard (lamps?.removeFirst()) != nil else { return }
        roundCorners(views: lamps!, cornerRadius: 10)
    }

    private func roundCorners(views: [UIView], cornerRadius: CGFloat) {
        views.forEach { (view) in
            view.layer.cornerRadius = cornerRadius
        }
    }
}
