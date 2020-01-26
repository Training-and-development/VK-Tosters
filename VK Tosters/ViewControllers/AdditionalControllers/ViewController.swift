//
//  ViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import Kingfisher

class ViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupObservers()
    }
    
    private func setupNavigationController() {
        let rightButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(manageAccountAction(_:)))
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
    
    @objc func manageAccountAction(_ sender: Any) {
        guard sessionStateCheck() == .authorized else {
            ApiV1.authorize()
            return
        }
        self.showPopup(headerText: "Выход из аккаунта", descriptionText: "Вы действительно хотите выйти?", confrimText: nil, declineText: "Выйти")
    }
    
    override func confrimAction() {
        print("tap")
    }
    
    override func declineAction() {
        print("tap")
        ApiV1.logout()
    }

    @IBAction func onFriendsAction(_ sender: Any) {
        self.performSegue(withIdentifier: "friendsSegue", sender: self)
    }
}
