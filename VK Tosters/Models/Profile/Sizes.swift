//
//  Sizes.swift
//  VK Tosters
//
//  Created by programmist_np on 28/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Sizes: NSObject {
    var type: String = ""
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
    
    convenience init(JSON: JSON) {
        self.init()
        self.type = JSON["type"].stringValue
        self.url = JSON["url"].stringValue
        self.width = JSON["width"].intValue
        self.height = JSON["height"].intValue
    }
}
