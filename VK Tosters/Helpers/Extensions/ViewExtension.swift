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
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
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
}
