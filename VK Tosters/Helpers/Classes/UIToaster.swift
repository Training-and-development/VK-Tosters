//
//  UIToaster.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit

public enum ToastStyle: Int {
    case `default` = 1, success, warning, error
}

open class UIToaster: UIView {
    open var toastHeight: CGFloat = 36.0
    open var toast = UIToasterView(frame: .zero, style: .default, message: "", font: UIFont(name: "Lato-Regular", size: 13.5)!)
    
    open func show(view: UIView, style: ToastStyle, message: String, duration: TimeInterval) {
        self.toast = UIToasterView(frame: CGRect(x: 0, y: -self.toastHeight, width: view.frame.width, height: self.toastHeight), style: style, message: message, font: UIFont(name: "Lato-Regular", size: 13)!)
        view.addSubview(self.toast)
        
        UIView.animate(withDuration: 0.25, animations: {
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
                toast.frame = CGRect(x: 0, y: -self.toastHeight, width: view.frame.width, height: self.toastHeight)
                view.layoutIfNeeded()
            }, completion: { finished in
                if finished {
                    toast.removeFromSuperview()
                }
            })
        } else {
            UIView.performWithoutAnimation {
                toast.frame = CGRect(x: 0, y: -self.toastHeight, width: view.frame.width, height: self.toastHeight)
                toast.removeFromSuperview()
            }
        }
    }
}

open class UIToasterView: UIView {
    public init(frame: CGRect, style: ToastStyle, message: String, font: UIFont) {
        super.init(frame: frame)
        
        var color: UIColor!
        
        switch style {
        case .default:
            color = Colors.shared.blue
        case .success:
            color = Colors.shared.green
        case .warning:
            color = Colors.shared.orange
        case .error:
            color = Colors.shared.red
        }
        self.backgroundColor = color
        
        let label = UILabel(frame: CGRect(origin: .zero, size: frame.size))
        label.font = font
        label.textColor = .white
        label.numberOfLines = 0
        label.text = message
        label.textAlignment = .center
        
        self.addSubview(label)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
