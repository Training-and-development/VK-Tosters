//
//  User.swift
//  VK Tosters
//
//  Created by programmist_np on 22/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: NSObject {
    var id: Int = 0
    var name: String = ""
    var isClosed: Bool = false
    var canAccessClosed: Bool = false
    var sex = 0, online: Int = 0
    var deactivated: String?
    var time: Int = 0
    var platform: Int = 0
    var photoOriginal: String = ""
    var parseTime: Date = Date(timeIntervalSince1970: 0)
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = "\(json["first_name"].stringValue) \(json["last_name"].stringValue)"
        self.isClosed = json["is_closed"].boolValue
        self.canAccessClosed = json["can_access_closed"].boolValue
        self.sex = json["sex"].intValue
        self.online = json["online"].intValue
        self.deactivated = json["deactivated"].stringValue
        self.time = json["last_seen"]["time"].intValue
        self.parseTime = Date(timeIntervalSince1970: TimeInterval(self.time))
        self.platform = json["last_seen"]["platform"].intValue
        self.photoOriginal = json["photo_max_orig"].stringValue
    }
}
