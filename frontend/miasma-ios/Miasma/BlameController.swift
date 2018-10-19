//
//  BlameController.swift
//  Miasma
//
//  Created by Lucia Reynoso on 10/18/18.
//  Copyright © 2018 Lucia Reynoso. All rights reserved.
//

import Foundation
import UIKit

class BlameController: UITableViewController {
    
    var safeZoneView: UIView? = nil
    var topSafeArea: CGFloat? = nil
    var bottomSafeArea: CGFloat? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .black
        
        // get screen information and set constraints
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
