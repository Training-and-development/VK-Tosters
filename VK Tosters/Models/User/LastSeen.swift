//
//  LastSeen.swift
//  VK Tosters
//
//  Created by programmist_np on 01/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class LastSeen: NSObject {
    var time: Int = 0
    var parseTime: Date = Date(timeIntervalSince1970: 0)
    var platform: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.time = json["time"].intValue
        self.parseTime = Date(timeIntervalSince1970: TimeInterval(self.time))
        self.platform = json["platform"].intValue
    }
}
