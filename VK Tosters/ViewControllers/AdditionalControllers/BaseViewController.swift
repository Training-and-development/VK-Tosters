//
//  BaseViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 24/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import PureLayout

open class BaseViewController: UIViewController {
    var toaster = UIToaster()
    var sessionState = VK.sessions.default.state
    var isFirstRun: Bool = true

    override open func viewDidLoad() {
        setupNavigationController()
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
    
    open var isLogged: Bool {
        guard currentSessionState == .authorized else { return false }
        return true
    }
    
    open var currentSessionState: SessionState {
        switch sessionState {
        case .destroyed:
            return .destroyed
        case .authorized:
            return .authorized
        case .initiated:
            return .initiated
        }
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override open func viewWillLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    open func setup() { }
    
    open func setupNavigationController() {
        self.navigationController?.navigationBar.frame = CGRect(origin: .zero, size: .zero)
    }
    
    open func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin(_:)), name: .onLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: .onLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onReachabilityStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(controlNetwork(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
    }
    
    open func setOnlinePlatform(platform: Int) -> String {
        switch platform {
        case 1: return "(мобильная версия)"
        case 2: return "(iPhone)"
        case 3: return "(iPad)"
        case 4: return "(Android)"
        case 5: return "(Windows Phone)"
        case 6: return "(Windows 10)"
        case 7: return "(полная версия)"
        default: return ""
        }
    }
    
    open func confrimAction() { }
    
    open func declineAction() { }
    
    open func showErrorView() { }
    
    open func hideErrorView() { }
    
    open func showLoadingView() { }
    
    open func hideLoadingView() { }
    
    @objc func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
        NotificationCenter.default.post(name: .onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.showToast(message: "Вы авторизованы", .success, duration: 1)
        })
    }
    
    @objc func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
        NotificationCenter.default.post(name: .onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.showToast(message: "Вы вышли из аккаунта", .warning, duration: 1)
        })
    }
    
    @objc func onReachabilityStatusChanged(_ notification: Notification) { }
    
    @objc private func controlNetwork(_ notification: Notification) {
        if let info = notification.userInfo {
            if info[ReachabilityNotificationStatusItem] != nil {
                if (SwiftReachability.sharedManager?.isReachable())! {
                    guard !isFirstRun else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.showToast(message: CommonLocalization.connected, .default, duration: 1)
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.showToast(message: CommonLocalization.notConnected, .error, duration: -1)
                    })
                }
            }
        }
    }
}
