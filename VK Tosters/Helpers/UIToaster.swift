//
//  UIToaster.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit

enum ToastStyle: Int {
    case `default` = 1, success, warning, error
}

class UIToaster: UIView {
    var toastHeight: CGFloat = 36.0
    var toast = UIToasterView(frame: .zero, style: .default, message: "", font: UIFont(name: "Lato-Regular", size: 13)!)
    
    func show(view: UIView, style: ToastStyle, message: String, duration: TimeInterval) {
        toast = UIToasterView(frame: CGRect(x: 0, y: -toastHeight, width: view.frame.width, height: toastHeight), style: style, message: message, font: UIFont(name: "Lato-Regular", size: 13)!)
        view.addSubview(toast)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.toast.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: self.toastHeight)
            view.layoutIfNeeded()
        }, completion: { finished in
            guard duration > 0 else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.hide(view: view, toast: self.toast, isNeedAnimation: true)
            })
        })
    }
    
    func hide(view: UIView, toast: UIToasterView, isNeedAnimation: Bool) {
        if isNeedAnimation {
            UIView.animate(withDuration: 0.2, animations: {
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

class UIToasterView: UIView {
    init(frame: CGRect, style: ToastStyle, message: String, font: UIFont) {
        super.init(frame: frame)
        
        var color: UIColor!
        
        switch style {
        case .default:
            color = Colors.shared.green
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
