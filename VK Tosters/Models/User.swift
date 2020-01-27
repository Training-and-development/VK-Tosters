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
    var id: String = ""
    var name: String = ""
    var screenName: String = ""
    var isClosed: Bool = false
    var canAccessClosed: Bool = false
    var sex = 0, online: Int = 0
    var deactivated: String?
    var time: Int = 0
    var platform: Int = 0
    var photoOriginal: String = ""
    var parseTime: Date = Date(timeIntervalSince1970: 0)
    
    convenience init(jsonFullUser: JSON) {
        self.init()
        self.id = jsonFullUser["id"].stringValue
        self.name = "\(jsonFullUser["first_name"].stringValue) \(jsonFullUser["last_name"].stringValue)"
        self.screenName = jsonFullUser["screen_name"].stringValue
        self.isClosed = jsonFullUser["is_closed"].boolValue
        self.canAccessClosed = jsonFullUser["can_access_closed"].boolValue
        self.sex = jsonFullUser["sex"].intValue
        self.online = jsonFullUser["online"].intValue
        self.deactivated = jsonFullUser["deactivated"].stringValue
        self.time = jsonFullUser["last_seen"]["time"].intValue
        self.parseTime = Date(timeIntervalSince1970: TimeInterval(self.time))
        self.platform = jsonFullUser["last_seen"]["platform"].intValue
        self.photoOriginal = jsonFullUser["photo_max_orig"].stringValue
    }
    
    convenience init(jsonRelationUser: JSON) {
        self.init()
        self.id = jsonRelationUser["id"].stringValue
        self.name = "\(jsonRelationUser["first_name"].stringValue) \(jsonRelationUser["last_name"].stringValue)"
        self.isClosed = jsonRelationUser["is_closed"].boolValue
        self.canAccessClosed = jsonRelationUser["can_access_closed"].boolValue
    }
}
