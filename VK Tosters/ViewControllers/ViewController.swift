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
    var sessionState = VK.sessions.default.state
    var toaster = UIToaster()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupObservers()
        
        SwiftReachability.sharedManager?.startMonitoring()
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin(_:)), name: NotificationName.shared.onLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: NotificationName.shared.onLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeSessionState(_:)), name: NotificationName.shared.onChangeSessionState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onReachabilityStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
    }
    
    private func setupNavigationController() {
        let rightButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(logoutAction(_:)))
        rightButton.title = "Login (out)"
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
        ApiV1.logout()
    }
}
extension ViewController {
    @objc func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
        NotificationCenter.default.post(name: NotificationName.shared.onChangeSessionState, object: nil)
        // toaster.show(view: self.view, style: .warning, message: "You authorized", duration: 0.3)
    }
    
    @objc func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
        NotificationCenter.default.post(name: NotificationName.shared.onChangeSessionState, object: nil)
        // toaster.show(view: self.view, style: .warning, message: "You logout", duration: 0.3)
    }
    
    @objc func onChangeSessionState(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.toaster.show(view: self.view, style: .warning, message: "Session changed from \(String(describing: self.sessionStateCheck()))", duration: 1)
        })
    }
}
extension ViewController {
    @objc func onReachabilityStatusChanged(_ notification: NSNotification) {
        if let info = notification.userInfo {
            if info[ReachabilityNotificationStatusItem] != nil {
                if (SwiftReachability.sharedManager?.isReachable())! {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.toaster.show(view: self.view, style: .success, message: "Подключено", duration: 1)
                        self.toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.toaster.show(view: self.view, style: .error, message: "Нет подключения к интернету", duration: -1)
                        self.toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
                    })
                }
            }
        }
    }
}
