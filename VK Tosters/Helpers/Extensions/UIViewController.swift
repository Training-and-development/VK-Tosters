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
extension UIViewController {
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
    
    func roundedImage(_ image: UIImage, cornerRadius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: image.size)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 1)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        image.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
    func resignFirstResponder<T: UIView>(_ object: T) {
        UIView.performWithoutAnimation {
            object.resignFirstResponder()
        }
    }
    
    func becomeFirstResponder<T: UIView>(_ object: T) {
        UIView.performWithoutAnimation {
            object.becomeFirstResponder()
        }
    }
}
extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
