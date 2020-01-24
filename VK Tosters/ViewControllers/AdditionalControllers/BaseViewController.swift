//
//  BaseViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 24/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK

open class BaseViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImage: UIImageView!
    
    var toaster = UIToaster()
    var sessionState = VK.sessions.default.state
    var isFirstRun: Bool = true

    override open func viewDidLoad() {
        setupObservers()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isFirstRun = false
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isFirstRun = true
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin(_:)), name: NotificationName.shared.onLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: NotificationName.shared.onLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onReachabilityStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
    }
    
    func setupError() {
        errorLabel.text = "Произошла ошибка подключения"
        errorLabel.textColor = Colors.shared.metal
        errorImage.image = errorImage.image?.withRenderingMode(.alwaysTemplate)
        errorImage.tintColor = Colors.shared.metal
    }
    
    open func confrimAction() { }
    
    open func declineAction() { }
    
    open func showErrorView() { }
    
    @objc func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
        NotificationCenter.default.post(name: NotificationName.shared.onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.showToast(message: "Вы авторизованы", .warning, duration: 1)
        })
    }
    
    @objc func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
        NotificationCenter.default.post(name: NotificationName.shared.onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.showToast(message: "Вы вышли из аккаунта", .warning, duration: 1)
        })
    }
    
    @objc func onReachabilityStatusChanged(_ notification: NSNotification) {
        if let info = notification.userInfo {
            if info[ReachabilityNotificationStatusItem] != nil {
                if (SwiftReachability.sharedManager?.isReachable())! {
                    guard !isFirstRun else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.showToast(message: "Подключено", .default, duration: 1)
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.showToast(message: "Нет подключения к интернету", .error, duration: -1)
                    })
                }
            }
        }
    }
}
