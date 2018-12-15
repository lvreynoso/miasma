//
//  CountdownViewController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 12/14/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    var timer: Timer?
    
    @IBOutlet weak var yearDigitOne: UIImageView!
    @IBOutlet weak var yearDigitTwo: UIImageView!
    @IBOutlet weak var monthDigitOne: UIImageView!
    @IBOutlet weak var monthDigitTwo: UIImageView!
    @IBOutlet weak var dayDigitOne: UIImageView!
    @IBOutlet weak var dayDigitTwo: UIImageView!
    
    @IBOutlet weak var hourDigitOne: UIImageView!
    @IBOutlet weak var hourDigitTwo: UIImageView!
    @IBOutlet weak var minuteDigitOne: UIImageView!
    @IBOutlet weak var minuteDigitTwo: UIImageView!
    @IBOutlet weak var secondDigitOne: UIImageView!
    @IBOutlet weak var secondDigitTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateClock()
        startUpdating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func updateClock() {
        var deadline: Date?
        // access the countdown date
        guard let deadlineUrl = Bundle.main.url(forResource: "Deadline", withExtension: "plist") else {
            print("can't find Deadline.plist")
            return
        }
        do {
            let deadlinePlist = try PropertyListSerialization.propertyList(from: Data(contentsOf: deadlineUrl), options: [], format: nil) as? [String: Any]
            
            deadline = deadlinePlist?["Point of No Return"] as? Date
        } catch {
            print("can't create array from plist")
            return
        }
        // where the magic happens
        guard let pointOfNoReturn = deadline else {
            print("Couldn't find a date to count down to...")
            return
        }
        let apocalypse = Interval.until(pointOfNoReturn)
        
        // convert the interval to strings of digits
        let yearOne: String = "d" + String(apocalypse[0] / 10)
        let yearTwo: String = "d" + String(apocalypse[0] % 10)
        let monthOne: String = "d" + String(apocalypse[1] / 10)
        let monthTwo: String = "d" + String(apocalypse[1] % 10)
        let dayOne: String = "d" + String(apocalypse[2] / 10)
        let dayTwo: String = "d" + String(apocalypse[2] % 10)
        let hourOne: String = "d" + String(apocalypse[3] / 10)
        let hourTwo: String = "d" + String(apocalypse[3] % 10)
        let minuteOne: String = "d" + String(apocalypse[4] / 10)
        let minuteTwo: String = "d" + String(apocalypse[4] % 10)
        let secondOne: String = "d" + String(apocalypse[5] / 10)
        let secondTwo: String = "d" + String(apocalypse[5] % 10)
        
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
                self.updateClock()
            })
        }
    }
}
