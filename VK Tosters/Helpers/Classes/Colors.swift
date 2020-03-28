//
//  Colors.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import UIKit

struct ToasterColors {
    static let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    static let smoke = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
    static let lightGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    static let gray = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
    static let middleGray = #colorLiteral(red: 0, green: 0.1098039216, blue: 0.2392156863, alpha: 0.0515036387)
    static let darkGray = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1)
    static let metal = UIColor(red: 0.71, green: 0.71, blue: 0.71, alpha: 1)
    static let dark = #colorLiteral(red: 0.2295962881, green: 0.2295962881, blue: 0.2295962881, alpha: 1)
    static let fullDark = #colorLiteral(red: 0.1207606282, green: 0.1207606282, blue: 0.1207606282, alpha: 1)
    static let black = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha:1)
    static let darkGrape = UIColor(red: 0.2, green: 0.2, blue: 0.27, alpha: 1)
    static let grape = UIColor(red: 0.22, green: 0.23, blue: 0.3, alpha: 1)
    static let sea = UIColor(red: 0.15, green: 0.45, blue: 0.66, alpha: 1)
    static let sapphire = UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1)
    static let blue = UIColor(red:0.16, green:0.38, blue:0.92, alpha:1.00)
    static let green = #colorLiteral(red: 0.2941176471, green: 0.7019607843, blue: 0.2941176471, alpha: 1)
    static let yellow = UIColor(red: 1.0, green: 0.87, blue: 0.35, alpha: 1)
    static let orange = UIColor(red: 1.0, green: 0.67, blue: 0.2, alpha: 1)
    static let red = UIColor(red: 1.0, green: 0.42, blue: 0.39, alpha: 1)
    static let space = UIColor(red: 0.02, green: 0.02, blue: 0.04, alpha: 1)
}

extension UIColor {
    class var toasterWhite: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return ToasterColors.black
                } else {
                    return ToasterColors.white
                }
            }
        } else {
            return ToasterColors.white
        }
    }
    
    class var toasterSmoke: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return ToasterColors.fullDark
                } else {
                    return ToasterColors.smoke
                }
            }
        } else {
            return ToasterColors.smoke
        }
    }
    
    class var toasterLightGray: UIColor {
        return ToasterColors.lightGray
    }
    
    class var toasterGray: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return ToasterColors.dark
                } else {
                    return ToasterColors.metal
                }
            }
        } else {
            return ToasterColors.metal
        }
    }
    
    class var toasterMiddleGray: UIColor {
        return ToasterColors.middleGray
    }
    
    class var toasterDarkGray: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return ToasterColors.dark
                } else {
                    return ToasterColors.darkGray
                }
            }
        } else {
            return ToasterColors.darkGray
        }
    }
    
    class var toasterMetal: UIColor {
        return ToasterColors.metal
    }
    
    class var toasterDark: UIColor {
        return ToasterColors.dark
    }
    
    class var toasterFullDark: UIColor {
        return ToasterColors.fullDark
    }
    
    class var toasterBlack: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return ToasterColors.white
                } else {
                    return ToasterColors.black
                }
            }
        } else {
            return ToasterColors.black
        }
    }
    
    class var toasterDarkGrape: UIColor {
        return ToasterColors.darkGrape
    }
    
    class var toasterGrape: UIColor {
        return ToasterColors.grape
    }
    
    class var toasterSea: UIColor {
        return ToasterColors.sea
    }
    
    class var toasterSapphire: UIColor {
        return ToasterColors.sapphire
    }
    
    class var toasterBlue: UIColor {
        return ToasterColors.blue
    }
    
    class var toasterGreen: UIColor {
        return ToasterColors.green
    }
    
    class var toasterYellow: UIColor {
        return ToasterColors.yellow
    }
    
    class var toasterOrange: UIColor {
        return ToasterColors.orange
    }
    
    class var toasterRed: UIColor {
        return ToasterColors.red
    }
    
    class var toasterSpace: UIColor {
        return ToasterColors.space
    }
}
