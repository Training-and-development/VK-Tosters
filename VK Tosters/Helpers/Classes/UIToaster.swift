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

public enum ToastStyle: Int {
    case `default` = 1, success, warning, error
}

open class UIToaster: UIView {
    open var toastHeight: CGFloat = 36.0
    open var toast = UIToasterView(frame: .zero, style: .default, message: "", font: UIFont(name: "Lato-Regular", size: 13.5)!)
    
    open func show(view: UIView, style: ToastStyle, message: String, duration: TimeInterval) {
        self.toast = UIToasterView(frame: CGRect(x: 12, y: -self.toastHeight, width: view.frame.width - 24, height: self.toastHeight), style: style, message: message, font: UIFont(name: "Lato-Regular", size: 13)!)
        view.addSubview(self.toast)
        toast.alpha = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.toast.alpha = 1
            self.toast.frame = CGRect(x: 12, y: self.statusBarHeight, width: view.frame.width - 24, height: self.toastHeight)
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
                toast.alpha = 0
                toast.frame = CGRect(x: 12, y: -self.toastHeight, width: view.frame.width - 24, height: -self.toastHeight)
                view.layoutIfNeeded()
            }, completion: { finished in
                if finished {
                    toast.removeFromSuperview()
                }
            })
        } else {
            UIView.performWithoutAnimation {
                toast.alpha = 0
                toast.frame = CGRect(x: 12, y: -self.toastHeight, width: view.frame.width - 24, height: -self.toastHeight)
                toast.removeFromSuperview()
            }
        }
    }
    
    var statusBarHeight: CGFloat {
        let height = UIApplication.shared.statusBarFrame.height + 8
        return height
    }
}

open class UIToasterView: UIView {
    public init(frame: CGRect, style: ToastStyle, message: String, font: UIFont) {
        super.init(frame: frame)
        
        var color: UIColor!
        
        switch style {
        case .default:
            color = .toasterBlue
        case .success:
            color = .toasterGreen
        case .warning:
            color = .toasterOrange
        case .error:
            color = .toasterRed
        }
        self.backgroundColor = color
        
        let label = UILabel(frame: CGRect(origin: .zero, size: frame.size))
        label.font = font
        label.textColor = .white
        label.numberOfLines = 0
        label.text = message
        label.textAlignment = .center
        
        self.addSubview(label)
        self.setCorners(radius: 5)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
