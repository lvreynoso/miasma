//
//  RootController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 10/18/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import UIKit

class RootController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let clockController: ClockController = UIStoryboard(name: "Clock", bundle: nil).instantiateViewController(withIdentifier: "Clock") as! ClockController
        clockController.tabBarItem = UITabBarItem(title: "Countdown", image: UIImage(named: "countdown"), tag: 0)
        
        let poisonController: PoisonController = UIStoryboard(name: "Poisons", bundle: nil).instantiateViewController(withIdentifier: "Poisons") as! PoisonController
        poisonController.tabBarItem = UITabBarItem(title: "Poisons", image: UIImage(named: "poison"), tag: 1)
        
        let blameController: BlameController = UIStoryboard(name: "Blame", bundle: nil).instantiateViewController(withIdentifier: "Blame") as! BlameController
        blameController.tabBarItem = UITabBarItem(title: "Blame", image: UIImage(named: "blame"), tag: 2)
        
        viewControllers = [clockController, poisonController, blameController]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
