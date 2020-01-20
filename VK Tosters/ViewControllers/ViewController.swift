//
//  ViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("User state:", VK.sessions.default.state)
    }
    
    @IBAction func action(_ sender: AnyObject) {
        ApiV1.authorize()
    }
}

