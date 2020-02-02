//
//  StringExtension.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit

enum NameCases: String {
    case nom
    case gen
    case dat
    case acc
    case ins
    case abl
}

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
extension String{
    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }
    
    func withNameCase(nameCase: NameCases) -> String {
        return self
    }
}
extension BaseViewController {
    func getStringByDeclension(number: Int, arrayWords: [String?]) -> String {
        var resultString: String = ""
        let number = number % 100
        if number >= 11 && number <= 19 {
            resultString = arrayWords[2]!
        } else {
            let i: Int = number % 10
            switch i {
            case 1: resultString = arrayWords[0]!
                break
            case 2, 3, 4:
                resultString = arrayWords[1]!
                break
            default:
                resultString = arrayWords[2]!
                break
            }
        }
        return resultString
    }
}
