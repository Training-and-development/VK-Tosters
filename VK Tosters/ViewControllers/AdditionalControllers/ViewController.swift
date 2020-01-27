//
//  ViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK

class ViewController: BaseViewController, UIGestureRecognizerDelegate {
    let subBar = AndroidNavigationBar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 56)))

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isLogged {
            ApiV1.authorize()
        }
        setupNavigationController()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    override func setupNavigationController() {
        let rightButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(manageAccountAction(_:)))
        rightButton.title = "Управление"
        self.navigationItem.rightBarButtonItem = rightButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.toasterBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc func manageAccountAction(_ sender: Any) {
        guard currentSessionState == .authorized else {
            ApiV1.authorize()
            return
        }
        self.showPopup(headerText: "Выход из аккаунта", descriptionText: "Вы действительно хотите выйти?", confrimText: nil, declineText: "Выйти")
    }
    
    override func declineAction() {
        ApiV1.logout()
    }

    @IBAction func onFriendsAction(_ sender: Any) {
        self.performSegue(withIdentifier: "friendsSegue", sender: self)
    }
}
