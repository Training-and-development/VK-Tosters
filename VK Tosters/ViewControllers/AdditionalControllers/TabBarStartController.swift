//
//  TabBarStartController.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import SwiftyJSON
import Material

class TabBarStartController: BubbleTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        self.isMotionEnabled = true
        self.motionTabBarTransitionType = .fade
        tabBarController?.tabBar.backgroundColor = .toasterWhite
    }
}
