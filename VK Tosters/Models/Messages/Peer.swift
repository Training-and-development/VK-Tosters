//
//  Peer.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Peer: NSObject {
    var id: String = ""
    var type: String = ""
    var localId: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.type = json["type"].stringValue
        self.localId = json["local_id"].intValue
    }
}
