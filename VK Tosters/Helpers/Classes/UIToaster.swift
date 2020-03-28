//
//  UIToaster.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Material

public enum ToastStyle: Int {
    case `default` = 1, success, warning, error
}

open class UIToaster: UIView {
    open var toastHeight: CGFloat = 36.0
    open var toast = UIToasterView(frame: .zero, style: .default, message: "", font: RobotoFont.regular(with: 13.5))
    
    open func show(view: UIView, style: ToastStyle, message: String, duration: TimeInterval) {
        self.toast = UIToasterView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0), style: style, message: message, font: RobotoFont.regular(with: 13))
        view.addSubview(self.toast)
        self.toast.label?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.toast.label?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: self.toastHeight)
            self.toast.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: self.toastHeight)
            view.layoutIfNeeded()
        }, completion: { finished in
            guard duration > 0 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.hide(view: view, toast: self.toast, isNeedAnimation: true)
            })
        })
    }
    
    open func hide(view: UIView, toast: UIToasterView, isNeedAnimation: Bool) {
        if isNeedAnimation {
            UIView.animate(withDuration: 0.25, animations: {
                toast.label?.alpha = 0
                toast.label?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
                toast.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
                view.layoutIfNeeded()
            }, completion: { finished in
                if finished {
                    toast.removeFromSuperview()
                }
            })
        } else {
            UIView.performWithoutAnimation {
                toast.label?.alpha = 0
                toast.label?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
                toast.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
                toast.removeFromSuperview()
            }
        }
    }
}

open class UIToasterView: UIView {
    var label: UILabel?
    
    public init(frame: CGRect, style: ToastStyle, message: String, font: UIFont) {
        super.init(frame: frame)
        var color: UIColor!
        
        switch style {
        case .default:
            color = .toasterDarkGrape
        case .success:
            color = .toasterGreen
        case .warning:
            color = .toasterOrange
        case .error:
            color = .toasterRed
        }
        self.backgroundColor = color
        
        label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 36)))
        
        label?.font = font
        label?.textColor = .white
        label?.numberOfLines = 0
        label?.text = message
        label?.textAlignment = .center
        
        self.addSubview(label!)
        self.setTapticEngine(style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension UIToasterView {
    func setTapticEngine(style: ToastStyle) -> ()? {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        switch style {
        case .default:
            return nil
        case .error:
            return notificationFeedbackGenerator.notificationOccurred(.error)
        case .warning:
            return notificationFeedbackGenerator.notificationOccurred(.warning)
        case .success:
            return notificationFeedbackGenerator.notificationOccurred(.success)
        }
    }
}
