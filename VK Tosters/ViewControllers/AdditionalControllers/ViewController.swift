//
//  ViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import SwiftyJSON
import Kingfisher

class ViewController: BaseViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var viewTitleLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var mainTable: UITableView!
    
    var profile: JSON = JSON()
    
    let subBar = AndroidNavigationBar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 56)))

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.setRounded()
        avatarImageView.kf.setImage(with: URL(string: "http://vk.com/images/deactivated_kis.png"))
        if !isLogged {
            ApiV1.authorize()
        }
        setupImageTarget()
        setupNavigationController()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    override func setupNavigationController() {
        viewTitleLabel.text = "Меню"
        viewTitleLabel.font = UIFont(name: "Lato-Bold", size: 20)
        viewTitleLabel.textColor = .toasterBlack
        dividerView.autoSetDimension(.height, toSize: 0.5)
        dividerView.backgroundColor = .toasterMetal
        getMe()
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
    
    @objc override func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
        getMe()
    }
    
    @objc override func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
    }
    
    func setupImageTarget() {
        avatarImageView.isUserInteractionEnabled = true

        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTapping(recognizer:)))
        singleTap.numberOfTapsRequired = 1
        avatarImageView.addGestureRecognizer(singleTap)
    }
    
    func getMe() {
        guard currentSessionState == .authorized else { return }
        VK.API.Users.get([.fields: ApiUsersFields.getUsersField])
            .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
            .onSuccess { response in
                let responseJSON = JSON(response).arrayValue
                let myUser = responseJSON.map { User(jsonFullUser: $0) }
                self.setProfileImage(url: myUser[0].photo100)
        }
        .onError { error in
            print(String(describing: error))
        }
        .send()
    }
    
    func setProfileImage(url: String) {
        DispatchQueue.main.async {
            self.avatarImageView.kf.setImage(with: URL(string: url))
        }
    }

    @IBAction func onFriendsAction(_ sender: Any) {
        self.performSegue(withIdentifier: "friendsSegue", sender: self)
    }
    
    @objc func singleTapping(recognizer: UIGestureRecognizer) {
        guard currentSessionState == .authorized else {
            ApiV1.authorize()
            return
        }
        self.showPopup(headerText: "Выход из аккаунта", descriptionText: "Вы действительно хотите выйти?", confrimText: nil, declineText: "Выйти")
    }
}
