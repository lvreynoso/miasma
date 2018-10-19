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
    
    var deadline: Date?
    var apocalypse: String?
    var clockValues: UILabel!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        let bounds = CGRect(x: 0, y: 40, width: self.view.bounds.width, height: self.view.bounds.height - 40)
        
        let safeArea = UIView(frame: bounds)
        // testBoundaries(in: safeArea)
        setupCountdownClock(in: safeArea)
        setupExplainerLabel(in: safeArea)
        self.view.addSubview(safeArea)
        
        startUpdating()
    }
    
    
    func setupCountdownClock(in clockView: UIView) {
        // access the countdown date
        guard let deadlineUrl = Bundle.main.url(forResource: "Deadline", withExtension: "plist") else {
            print("can't find Deadline.plist")
            return
        }
        do {
            let deadlinePlist = try PropertyListSerialization.propertyList(from: Data(contentsOf: deadlineUrl), options: [], format: nil) as? [String: Any]
            
            self.deadline = deadlinePlist?["Point of No Return"] as? Date
        } catch {
            print("can't create array from plist")
            return
        }
        
        // where the magic happens
        if self.deadline != nil {
            self.apocalypse = Interval.until(self.deadline!)
        }
        
        // create the value labels
        clockValues = setupClockValueLabel(apocalypse!)
        clockValues.center = CGPoint(x: clockView.center.x - CGFloat(150), y: (clockValues!.bounds.size.height / 2))
        
        // create the ymd-hms labels
        let clockLabels = setupClockLabelText("years\nmonths\ndays\nhours\nminutes\nseconds")
        clockLabels.center = CGPoint(x: clockView.center.x, y: (clockLabels.bounds.size.height / 2))
        
       
        
        clockView.addSubview(clockValues)
        clockView.addSubview(clockLabels)
    }
    
    func setupExplainerLabel(in clockView: UIView) {
        let explainerLabel = UILabel()
        explainerLabel.text = "until the point of no return."
        explainerLabel.textAlignment = .center
        explainerLabel.textColor = .white
        explainerLabel.font = UIFont(name: "Helvetica", size: 30)
        explainerLabel.sizeToFit()
        explainerLabel.center = CGPoint(x: clockView.center.x, y: clockView.center.y)
        
        clockView.addSubview(explainerLabel)
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
    
    func startUpdating() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
                guard let deadline = self.deadline else { return }
                let updatedApocalypse = Interval.until(deadline)
                self.clockValues.text = updatedApocalypse
            })
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

}
