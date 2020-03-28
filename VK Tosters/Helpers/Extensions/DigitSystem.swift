//
//  DigitSystem.swift
//  PhotoPicker
//
//  Created by programmist_np on 23.03.2020.
//  Copyright © 2020 OrenDeveloper. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
    
    var kmFormatted: String {
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", locale: Locale.current,self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    var kmFormatted: String {
        if self >= 10000, self <= 999999 {
            return String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }
        if self > 999999 {
            return String(format: "%.1fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        return String(format: "%.0f", locale: Locale.current,self)
    }
}
extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
extension CGFloat {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
extension String {
    var toCGFloat: CGFloat? {
      guard let doubleValue = Double(self) else { return nil }
      return CGFloat(doubleValue)
    }
}
extension TimeInterval {
    var hz: Double {
        return 1.0 / self
    }
}
