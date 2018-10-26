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
    var apocalypse: [Int] = []
    var clockValues: UILabel!
    var timer: Timer?
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var learnMore: UIButton!
    @IBOutlet weak var infoView: UIView!
    
    // clock digits
    var yearDigitOne: UIImageView?
    var yearDigitTwo: UIImageView?
    var monthDigitOne: UIImageView?
    var monthDigitTwo: UIImageView?
    var dayDigitOne: UIImageView?
    var dayDigitTwo: UIImageView?
    
    var hourDigitOne: UIImageView?
    var hourDigitTwo: UIImageView?
    var minuteDigitOne: UIImageView?
    var minuteDigitTwo: UIImageView?
    var secondDigitOne: UIImageView?
    var secondDigitTwo: UIImageView?
    
    // clock year month day labels
    var yearLabel: UIImageView?
    var monthLabel: UIImageView?
    var dayLabel: UIImageView?
    var colonOne: UIImageView?
    var colonTwo: UIImageView?
    
    // view constraints
    var constraints: [NSLayoutConstraint] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clockView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        constraints = setupConstraints(transitionFrame: nil)
        NSLayoutConstraint.activate(constraints)
        setupCountdownClock(in: clockView, transitionSize: nil)
        updateClock(in: clockView)
        startUpdating()
        print(self.view.frame)
        print(clockView.frame)
        print(infoView.frame)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        clockView.subviews.map { $0.removeFromSuperview() }
        NSLayoutConstraint.deactivate(constraints)
        constraints = setupConstraints(transitionFrame: size)
        NSLayoutConstraint.activate(constraints)
        print(self.view.frame)
        print(clockView.frame)
        print(infoView.frame)
        print("flipped!")
    }
    
    func setupConstraints(transitionFrame: CGSize?) -> [NSLayoutConstraint] {
        var outputConstraints: [NSLayoutConstraint] = []
        let currentFrame: CGSize = transitionFrame ?? CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        let portraitMode: Bool = currentFrame.height >= currentFrame.width
        
        // update clock constraints
        if portraitMode {
            // square clock
            let clockHeight = NSLayoutConstraint(item: clockView, attribute: .height, relatedBy: .equal, toItem: clockView, attribute: .width, multiplier: 0.6, constant: 0)
            outputConstraints.append(clockHeight)
        } else {
            let clockHeight = NSLayoutConstraint(item: clockView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0)
            outputConstraints.append(clockHeight)
        }
        let clockTrail = NSLayoutConstraint(item: clockView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let clockLead = NSLayoutConstraint(item: clockView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let clockCenterX = NSLayoutConstraint(item: clockView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        outputConstraints.append(contentsOf: [clockTrail, clockLead, clockCenterX])
        
        // now to update the infoView constraints
        let infoViewTop = NSLayoutConstraint(item: infoView, attribute: .top, relatedBy: .equal, toItem: clockView, attribute: .bottom, multiplier: 1, constant: 0)
        let infoViewHeight = NSLayoutConstraint(item: infoView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: 1, constant: 250)
        let infoViewTrail = NSLayoutConstraint(item: infoView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let infoViewLead = NSLayoutConstraint(item: infoView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let infoViewCenterX = NSLayoutConstraint(item: infoView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        outputConstraints.append(contentsOf: [infoViewTop, infoViewHeight, infoViewTrail, infoViewLead, infoViewCenterX])
        
        return outputConstraints
    }
    
    func setupCountdownClock(in setupView: UIView, transitionSize: CGSize?) {
        var maxWidth: CGFloat = 0
        if let transition = transitionSize {
            maxWidth = transition.width
        } else {
            maxWidth = (setupView.frame.maxX - setupView.frame.minX)
        }
        let width = maxWidth * 0.9
        let ymdSpacing = (maxWidth - width) / 10
        let ymdWidth = width / 9
        let ymdHeight = ymdWidth * 1.817
        ymdClock(in: setupView, spacing: ymdSpacing, imgWidth: ymdWidth, imgHeight: ymdHeight)
        
        let hmsSpacing = (maxWidth - width) / 9
        let hmsWidth = width / 7
        
        // TODO: Fix this ugly code
        var spacing: [CGFloat] = []
        spacing.append((hmsWidth / 4) + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing)
        spacing.append((hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing + hmsWidth + hmsSpacing + (hmsWidth / 4) + hmsSpacing + hmsWidth + hmsSpacing)
        hmsClock(in: setupView, spacing: spacing, imgWidth: hmsWidth, yBuffer: ymdHeight / 1.5)
    }
    
    func ymdClock(in setupView: UIView, spacing: CGFloat, imgWidth: CGFloat, imgHeight: CGFloat) {
        var displays: [UIImageView] = []
        let labelHeight: CGFloat = 0.85 * imgWidth
        for index in 1...9 {
            switch index {
            case 3, 6, 9:
                // label code
                let yPosition: CGFloat = labelHeight / 2
                let shape = CGRect(x: (CGFloat(index) * spacing) + (CGFloat(index) * (imgWidth)) - imgWidth, y: yPosition + (imgHeight - labelHeight), width: imgWidth, height: labelHeight)
                let thisView = UIImageView(frame: shape)
                displays.append(thisView)
            default:
                // digit code
                let yPosition: CGFloat = imgHeight / 2
                let shape = CGRect(x: (CGFloat(index) * spacing) + (CGFloat(index) * (imgWidth)) - imgWidth, y: yPosition, width: imgWidth, height: imgHeight)
                let thisView = UIImageView(frame: shape)
                displays.append(thisView)
            }
        }
        
        // set the digits
        yearDigitOne = displays[0]
        yearDigitOne?.image = UIImage(named: "d8")
        if let addView = yearDigitOne {
            setupView.addSubview(addView)
        }
        yearDigitTwo = displays[1]
        yearDigitTwo?.image = UIImage(named: "d8")
        if let addView = yearDigitTwo {
            setupView.addSubview(addView)
        }
        yearLabel = displays[2]
        yearLabel?.image = UIImage(named: "dYR")
        if let addView = yearLabel {
            setupView.addSubview(addView)
        }
        monthDigitOne = displays[3]
        monthDigitOne?.image = UIImage(named: "d8")
        if let addView = monthDigitOne {
            setupView.addSubview(addView)
        }
        monthDigitTwo = displays[4]
        monthDigitTwo?.image = UIImage(named: "d8")
        if let addView = monthDigitTwo {
            setupView.addSubview(addView)
        }
        monthLabel = displays[5]
        monthLabel?.image = UIImage(named: "dMO")
        if let addView = monthLabel {
            setupView.addSubview(addView)
        }
        dayDigitOne = displays[6]
        dayDigitOne?.image = UIImage(named: "d8")
        if let addView = dayDigitOne {
            setupView.addSubview(addView)
        }
        dayDigitTwo = displays[7]
        dayDigitTwo?.image = UIImage(named: "d8")
        if let addView = dayDigitTwo {
            setupView.addSubview(addView)
        }
        dayLabel = displays[8]
        dayLabel?.image = UIImage(named: "dDA")
        if let addView = dayLabel {
            setupView.addSubview(addView)
        }
    }
    
    func hmsClock(in setupView: UIView, spacing: [CGFloat], imgWidth: CGFloat, yBuffer: CGFloat) {
        var displays: [UIImageView] = []
        let colonWidth = imgWidth / 4
        let colonHeight = colonWidth * 5.4
        let imgHeight = imgWidth * 1.817
        for index in 1...8 {
            switch index {
            case 3, 6:
                // colon code
                let yPosition: CGFloat = (colonHeight / 2) + (yBuffer * 2)
                let shape = CGRect(x: spacing[index - 1], y: yPosition + (imgHeight - colonHeight), width: colonWidth, height: colonHeight)
                let thisView = UIImageView(frame: shape)
                displays.append(thisView)
            default:
                // digit code
                let yPosition: CGFloat = (imgHeight / 2) + (yBuffer * 2)
                let shape = CGRect(x: spacing[index - 1], y: yPosition, width: imgWidth, height: imgHeight)
                let thisView = UIImageView(frame: shape)
                displays.append(thisView)
            }
        }
        
        hourDigitOne = displays[0]
        hourDigitOne?.image = UIImage(named: "d8")
        if let addView = hourDigitOne {
            setupView.addSubview(addView)
        }
        hourDigitTwo = displays[1]
        hourDigitTwo?.image = UIImage(named: "d8")
        if let addView = hourDigitTwo {
            setupView.addSubview(addView)
        }
        colonOne = displays[2]
        colonOne?.image = UIImage(named: "dC")
        if let addView = colonOne {
            setupView.addSubview(addView)
        }
        minuteDigitOne = displays[3]
        minuteDigitOne?.image = UIImage(named: "d8")
        if let addView = minuteDigitOne {
            setupView.addSubview(addView)
        }
        minuteDigitTwo = displays[4]
        minuteDigitTwo?.image = UIImage(named: "d8")
        if let addView = minuteDigitTwo {
            setupView.addSubview(addView)
        }
        colonTwo = displays[5]
        colonTwo?.image = UIImage(named: "dC")
        if let addView = colonTwo {
            setupView.addSubview(addView)
        }
        secondDigitOne = displays[6]
        secondDigitOne?.image = UIImage(named: "d8")
        if let addView = secondDigitOne {
            setupView.addSubview(addView)
        }
        secondDigitTwo = displays[7]
        secondDigitTwo?.image = UIImage(named: "d8")
        if let addView = secondDigitTwo {
            setupView.addSubview(addView)
        }
    }
    
    func updateClock(in updateView: UIView) {
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
        
        // convert the interval to strings of digits
        let yearOne: String = "d" + String(self.apocalypse[0] / 10)
        let yearTwo: String = "d" + String(self.apocalypse[0] % 10)
        let monthOne: String = "d" + String(self.apocalypse[1] / 10)
        let monthTwo: String = "d" + String(self.apocalypse[1] % 10)
        let dayOne: String = "d" + String(self.apocalypse[2] / 10)
        let dayTwo: String = "d" + String(self.apocalypse[2] % 10)
        let hourOne: String = "d" + String(self.apocalypse[3] / 10)
        let hourTwo: String = "d" + String(self.apocalypse[3] % 10)
        let minuteOne: String = "d" + String(self.apocalypse[4] / 10)
        let minuteTwo: String = "d" + String(self.apocalypse[4] % 10)
        let secondOne: String = "d" + String(self.apocalypse[5] / 10)
        let secondTwo: String = "d" + String(self.apocalypse[5] % 10)
        
        // print(yearOne+yearTwo+"y"+monthOne+monthTwo+"m"+dayOne+dayTwo+"d " + hourOne+hourTwo+":"+minuteOne+minuteTwo+":"+secondOne+secondTwo)
        
        yearDigitOne?.image = UIImage(named: yearOne, in: nil, compatibleWith: nil)
        yearDigitTwo?.image = UIImage(named: yearTwo, in: nil, compatibleWith: nil)
        monthDigitOne?.image = UIImage(named: monthOne, in: nil, compatibleWith: nil)
        monthDigitTwo?.image = UIImage(named: monthTwo, in: nil, compatibleWith: nil)
        dayDigitOne?.image = UIImage(named: dayOne, in: nil, compatibleWith: nil)
        dayDigitTwo?.image = UIImage(named: dayTwo, in: nil, compatibleWith: nil)
        hourDigitOne?.image = UIImage(named: hourOne, in: nil, compatibleWith: nil)
        hourDigitTwo?.image = UIImage(named: hourTwo, in: nil, compatibleWith: nil)
        minuteDigitOne?.image = UIImage(named: minuteOne, in: nil, compatibleWith: nil)
        minuteDigitTwo?.image = UIImage(named: minuteTwo, in: nil, compatibleWith: nil)
        secondDigitOne?.image = UIImage(named: secondOne, in: nil, compatibleWith: nil)
        secondDigitTwo?.image = UIImage(named: secondTwo, in: nil, compatibleWith: nil)
        
    }
    
    func startUpdating() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
                self.updateClock(in: self.clockView)
            })
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
