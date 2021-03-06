//
//  OutputViewController.swift
//  CalcLite
//
//  Created by adminaccount on 12/14/16.
//  Copyright © 2016 adminaccount. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController, OutputInterface {
    
    @IBOutlet var animationDisplay: UILabel!
    
    @IBOutlet weak var display: UILabel!
    func outputInfo(info: String) {
        display.text = info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    animationDisplay.center.x = self.view.frame.width + 30
    UIView.animate(withDuration: 1.5,
                   delay: 0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 30,
                   options: UIViewAnimationOptions(rawValue: UInt(5.0)),
                   animations: ({
                    self.animationDisplay.center.x = self.view.frame.width / 2
                   }),
                   completion: nil)
    }
}
