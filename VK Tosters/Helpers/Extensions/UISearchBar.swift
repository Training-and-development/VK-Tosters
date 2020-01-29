//
//  UISearchBar.swift
//  VK Tosters
//
//  Created by programmist_np on 27/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
import UIKit

extension UISearchBar {
    func setCenteredPlaceHolder() {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        
        //get the sizes
        let searchBarWidth = self.frame.width
        let placeholderIconWidth = textFieldInsideSearchBar?.leftView?.frame.width
        let placeHolderWidth = textFieldInsideSearchBar?.attributedPlaceholder?.size().width
        let offsetIconToPlaceholder: CGFloat = 8
        let placeHolderWithIcon = placeholderIconWidth! + offsetIconToPlaceholder
        
        let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - placeHolderWithIcon), vertical: 0)
        self.setPositionAdjustment(offset, for: .search)
    }
    
    func setDefaultPlaceHolder() {
        let offset = UIOffset(horizontal: 12, vertical: 0)
        self.setPositionAdjustment(offset, for: .search)
    }
}