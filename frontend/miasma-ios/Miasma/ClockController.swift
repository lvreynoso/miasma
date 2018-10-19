//
//  ClockController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 10/18/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import UIKit

class ClockController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        let bounds = CGRect(x: 0, y: 40, width: self.view.bounds.width, height: self.view.bounds.height - 40)
        
        let safeArea = UIView(frame: bounds)
        // testBoundaries(in: safeArea)
        setupCountdownClock(in: safeArea)
        self.view.addSubview(safeArea)
        
        print("view loaded!")

    }
    
    func testBoundaries(in testView: UIView) {
        let top = setupClockValueLabel("top")
        top.sizeToFit()
        top.center = CGPoint(x: testView.center.x, y: testView.bounds.minY)
        let bottom = setupClockValueLabel("bottom")
        bottom.sizeToFit()
        bottom.center = CGPoint(x: testView.center.x, y: testView.bounds.maxY)
        let cents = setupClockValueLabel("center")
        cents.sizeToFit()
        cents.center = testView.center
        
        testView.addSubview(top)
        testView.addSubview(bottom)
        testView.addSubview(cents)
    }
    
    func setupCountdownClock(in clockView: UIView) {
        let clockValues = setupClockValueLabel("16\n8\n2\n14\n12\n53")
        clockValues.center = CGPoint(x: clockView.center.x - CGFloat(150), y: (clockValues.bounds.size.height / 2))
        
        let clockLabels = setupClockLabelText("years\nmonths\ndays\nhours\nminutes\nseconds")
        clockLabels.center = CGPoint(x: clockView.center.x, y: (clockLabels.bounds.size.height / 2))
        
        let explainerLabel = UILabel()
        explainerLabel.text = "until the point of no return."
        explainerLabel.textAlignment = .center
        explainerLabel.textColor = .white
        explainerLabel.font = UIFont(name: "Helvetica", size: 30)
        explainerLabel.sizeToFit()
        explainerLabel.center = CGPoint(x: clockView.center.x, y: clockView.center.y)
        
        clockView.addSubview(clockValues)
        clockView.addSubview(clockLabels)
        clockView.addSubview(explainerLabel)
        
        print("labels added!")
    }
    
    func setupClockValueLabel(_ text: String) -> UILabel {
        let returnLabel = UILabel()
        returnLabel.numberOfLines = 6
        returnLabel.text = text
        returnLabel.textAlignment = .center
        returnLabel.textColor = .white
        returnLabel.font = UIFont(name: "Helvetica", size: 45)
        returnLabel.sizeToFit()
        
        return returnLabel
    }
    
    func setupClockLabelText(_ text: String) -> UILabel {
        let returnLabel = UILabel()
        returnLabel.numberOfLines = 6
        returnLabel.text = text
        returnLabel.textAlignment = .left
        returnLabel.textColor = .white
        returnLabel.font = UIFont(name: "Helvetica", size: 45)
        returnLabel.sizeToFit()
        
        return returnLabel
    }
    
}
