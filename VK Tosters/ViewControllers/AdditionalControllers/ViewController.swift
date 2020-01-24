//
//  ViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK

class ViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupObservers()
        
        SwiftReachability.sharedManager?.startMonitoring()
        
        self.view.isUserInteractionEnabled = true
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapView(_:)))
        gesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    private func setupNavigationController() {
        let rightButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(logoutAction(_:)))
        rightButton.title = "Управление"
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func sessionStateCheck() -> SessionState? {
        if sessionState == .destroyed {
            return .destroyed
        } else if sessionState == .authorized {
            return .authorized
        } else if sessionState == .initiated {
            return .initiated
        }
        return nil
    }
    
    @objc func logoutAction(_ sender: Any) {
        guard sessionStateCheck() == .authorized else {
            ApiV1.authorize()
            return
        }
        showPopup(headerText: "Выход из аккаунта", descriptionText: "Вы действительно хотите выйти?", confrimText: nil, declineText: "Выйти")
    }
    
    override func confrimAction() {
        guard sessionStateCheck() == .authorized else {
            ApiV1.authorize()
            return
        }
        ApiV1.logout()
    }
    
    @objc func onTapView(_ sender: Any) {
    }

    @IBAction func onFriendsAction(_ sender: Any) {
        self.performSegue(withIdentifier: "friendsSegue", sender: self)
    }
}
