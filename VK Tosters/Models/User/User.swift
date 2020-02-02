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
    var lastSeen: LastSeen = LastSeen()
    var photoOriginal: String = ""
    var photo100: String = ""
    var counters: Counters = Counters()
    var friendStatus: Int = 0
    
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
        self.lastSeen = LastSeen(json: jsonFullUser["last_seen"])
        self.photoOriginal = jsonFullUser["photo_max_orig"].stringValue
        self.photo100 = jsonFullUser["photo_100"].stringValue
        self.friendStatus = jsonFullUser["friend_status"].intValue
    }
    
    convenience init(jsonRelationUser: JSON) {
        self.init()
        self.id = jsonRelationUser["id"].stringValue
        self.name = "\(jsonRelationUser["first_name"].stringValue) \(jsonRelationUser["last_name"].stringValue)"
        self.isClosed = jsonRelationUser["is_closed"].boolValue
        self.canAccessClosed = jsonRelationUser["can_access_closed"].boolValue
    }
    
    convenience init(jsonProfileUser: JSON) {
        self.init()
        self.id = jsonProfileUser["id"].stringValue
        self.name = "\(jsonProfileUser["first_name"].stringValue) \(jsonProfileUser["last_name"].stringValue)"
        self.screenName = jsonProfileUser["screen_name"].stringValue
        self.canAccessClosed = jsonProfileUser["can_access_closed"].boolValue
        self.deactivated = jsonProfileUser["deactivated"].stringValue
        self.counters = Counters(json: jsonProfileUser["counters"])
        self.photoOriginal = jsonProfileUser["photo_max_orig"].stringValue
        self.photo100 = jsonProfileUser["photo_100"].stringValue
        self.lastSeen = LastSeen(json: jsonProfileUser["last_seen"])
        self.sex = jsonProfileUser["sex"].intValue
        self.online = jsonProfileUser["online"].intValue
        self.friendStatus = jsonProfileUser["friend_status"].intValue
    }
    
    convenience init(messageJSON: JSON) {
        self.init()
        self.id = messageJSON["id"].stringValue
        self.name = "\(messageJSON["first_name"].stringValue) \(messageJSON["last_name"].stringValue)"
        self.online = messageJSON["online"].intValue
        self.lastSeen = LastSeen(json: messageJSON["last_seen"])
        self.photo100 = messageJSON["photo_100"].stringValue
    }
}
