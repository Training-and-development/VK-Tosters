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
    var isFirstRun: Bool = true

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isFirstRun = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isFirstRun = true
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin(_:)), name: NotificationName.shared.onLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: NotificationName.shared.onLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onChangeSessionState(_:)), name: NotificationName.shared.onChangeSessionState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onReachabilityStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
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
    
    func showPopup() {
        guard let popupViewController = storyboard?.instantiateViewController(withIdentifier: "popupViewController") as? PopupViewController else { return }
        popupViewController.setParameters(duration: 0.4, dimmingViewAlpha: 0.2, headerText: "Выход из аккаунта", descriptionText: "Вы действительно хотите выйти?", confrimText: nil, declineText: "Выйти")
        popupViewController.popupDelegate = self
        popupViewController.rootController = self
        popupViewController.modalPresentationStyle = .custom
        present(popupViewController, animated: true, completion: nil)
        popupViewController.confrimButton.isHidden = true
    }
    
    @objc func logoutAction(_ sender: Any) {
        guard sessionStateCheck() == .authorized else {
            ApiV1.authorize()
            return
        }
        showPopup()
    }
    
    @objc func confrimAction() {
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
extension ViewController: BottomPopupDelegate {
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
extension ViewController {
    @objc func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
        NotificationCenter.default.post(name: NotificationName.shared.onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.toaster.show(view: self.view, style: .success, message: "Вы авторизованы", duration: 1)
        })
    }
    
    @objc func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
        NotificationCenter.default.post(name: NotificationName.shared.onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.toaster.show(view: self.view, style: .warning, message: "Вы вышли из аккаунта", duration: 1)
        })
    }
    
    @objc func onChangeSessionState(_ notification: Notification) {
        
    }
}
extension ViewController {
    @objc func onReachabilityStatusChanged(_ notification: NSNotification) {
        if let info = notification.userInfo {
            if info[ReachabilityNotificationStatusItem] != nil {
                if (SwiftReachability.sharedManager?.isReachable())! {
                    guard !isFirstRun else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        for controller in self.navigationController!.viewControllers {
                            self.toaster.hide(view: controller.view, toast: self.toaster.toast, isNeedAnimation: false)
                            self.toaster.show(view: controller.view, style: .default, message: "Подключено", duration: 1)
                        }
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
                        self.toaster.show(view: self.view, style: .error, message: "Нет подключения к интернету", duration: -1)
                    })
                }
            }
        }
    }
}
