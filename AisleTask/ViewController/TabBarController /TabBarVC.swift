//
//  TabBarVC.swift
//  AisleTask
//
//  Created by K V Jagadeesh babu on 27/06/25.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        selectedIndex = 1
    }
    
}
