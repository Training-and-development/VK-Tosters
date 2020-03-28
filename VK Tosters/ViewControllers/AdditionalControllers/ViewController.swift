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
import Material

class ViewController: BaseViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var menuTabItem: UITabBarItem!
    let defaults = UserDefaults.standard
    let names: [String] = ["Профиль", "Друзья", "Фотки", "Видео", "Музыка", "Избранное", "Понравившиеся", "Уведомления", "Настройки"]
    let images: [UIImage?] = [UIImage(named: "smile_outline_24"), UIImage(named: "users_outline_24"), UIImage(named: "camera_outline_24"), UIImage(named: "videocam_outline_24"), UIImage(named: "music_outline_24"), UIImage(named: "favorite_outline_24"), UIImage(named: "like_outline_24"), UIImage(named: "notifcation_outline_24"), UIImage(named: "settings_outline_24")]
    
    var profile: JSON = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        toolbar.title = "Аккаунт"
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func configureTableView() {
        super.configureTableView()
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.separatorStyle = .singleLine
        mainTable.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        mainTable.separatorColor = .toasterDarkGray
        mainTable.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        self.view.addSubview(loadingContainer)
        loadingContainer.autoPinEdgesToSuperviewEdges()
        hideLoadingView()
    }
    
    @objc func manageAccountAction(_ sender: Any) {
        guard currentSessionState == .authorized else {
            ApiV1.authorize()
            return
        }
        // self.showPopup(headerText: "Выход из аккаунта", descriptionText: "Вы действительно хотите выйти?", confrimText: nil, declineText: "Выйти")
    }
    
    override func declineAction() {
        ApiV1.logout()
    }
    
    @objc override func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
    }
    
    @objc override func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.setup(title: self.names[indexPath.row], icon: self.images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let userId = UserDefaults.standard.string(forKey: "userId")
            let profileViewController = self.storyboard?.instantiateViewController(identifier: "profileViewController") as! ProfileViewController
            ProfileViewController.userId = userId!
            self.navigationController?.pushViewController(profileViewController, animated: true)
        default:
            self.showToast(message: "Секция недоступна", .warning)
        }
    }
}
