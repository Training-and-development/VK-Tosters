//
//  City.swift
//  VK Tosters
//
//  Created by programmist_np on 25/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class City: NSObject {
    var id: Int = 0
    var title: String = ""
    
    convenience init(JSON: JSON) {
        self.init()
        self.id = JSON["id"].intValue
        self.title = JSON["title"].stringValue
    }
}
