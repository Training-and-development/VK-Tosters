//
//  ViewExtension.swift
//  VK Tosters
//
//  Created by programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // Добавление блюра к View
    func blurry() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth]
        self.addSubview(blurView)
    }
    
    // Задать скругления
    func setCorners(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    // Сделать круглым
    func setRounded() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
    
    // Сделать обводку
    func setupBorder(width: CGFloat, color: UIColor) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func hideViewWithAnimation() {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.isHidden = true
        })
    }
    
    func showViewWithAnimation() {
        self.isHidden = false
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.alpha = 1
        })
    }
    
    func changeColorViewWithAnimation(color: UIColor) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.backgroundColor = color
        })
    }
}
