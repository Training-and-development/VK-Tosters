//
//  ViewControllerExtension.swift
//  VK Tosters
//
//  Created by programmist_np on 23/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit
import SwiftyVK

public protocol UIViewControllerProtocol: class {
    func confrimAction(controller: UIViewController?)
}
extension BaseViewController {
    open func showPopup(headerText: String, descriptionText: String, confrimText: String?, declineText: String?) {
        guard let popupViewController = storyboard?.instantiateViewController(withIdentifier: "popupViewController") as? PopupViewController else { return }
        popupViewController.setParameters(duration: 0.3, dimmingViewAlpha: 0.2, headerText: headerText, descriptionText: descriptionText, confrimText: confrimText, declineText: declineText)
        popupViewController.popupDelegate = self
        popupViewController.rootController = self
        popupViewController.modalPresentationStyle = .custom
        present(popupViewController, animated: true, completion: nil)
        popupViewController.confrimButton.isHidden = confrimText == nil ? true : false
        popupViewController.declineButton.isHidden = declineText == nil ? true : false
    }
    
    func showToast(message: String, _ style: ToastStyle, duration: TimeInterval = 1) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
            self.toaster.show(view: self.view, style: style, message: message, duration: duration)
        })
    }
}
extension UIViewController: BottomPopupDelegate {
    public func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    public func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    public func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    public func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    public func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    public func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
} 
