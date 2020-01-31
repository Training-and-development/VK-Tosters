//
//  Writing.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Writing: NSObject {
    var isAllowed: Bool = false
    var reason: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.isAllowed = json["allowed"].boolValue
        self.reason = json["reason"].intValue
    }
}
