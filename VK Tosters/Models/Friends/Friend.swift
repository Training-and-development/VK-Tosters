//
//  Friend.swift
//  VK Tosters
//
//  Created by programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Friend: Object {
    var id: String = ""
    var name: String = ""
    var isClosed: Bool = false
    var canAccessClosed: Bool = false
    var sex = 0, online: Int = 0
    var trackCode: String = ""
    var deactivated: String?
    var lastSeen: LastSeen = LastSeen()
    var photo100: String = ""
    var parseTime: Date = Date(timeIntervalSince1970: 0)
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].stringValue
        self.name = "\(json["first_name"].stringValue) \(json["last_name"].stringValue)"
        self.isClosed = json["is_closed"].boolValue
        self.canAccessClosed = json["can_access_closed"].boolValue
        self.sex = json["sex"].intValue
        self.online = json["online"].intValue
        self.trackCode = json["track_code"].stringValue
        self.deactivated = json["deactivated"].stringValue
        self.lastSeen = LastSeen(json: json["last_seen"])
        self.photo100 = json["photo_100"].stringValue
    }
}
