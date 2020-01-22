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
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var isClosed: Bool = false
    @objc dynamic var canAccessClosed: Bool = false
    @objc dynamic var sex = 0, online: Int = 0
    @objc dynamic var trackCode: String = ""
    @objc dynamic var deactivated: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case sex
        case online
        case trackCode = "track_code"
        case deactivated
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.isClosed = json["is_closed"].boolValue
        self.canAccessClosed = json["can_access_closed"].boolValue
        self.sex = json["sex"].intValue
        self.online = json["online"].intValue
        self.trackCode = json["track_code"].stringValue
        self.deactivated = json["deactivated"].stringValue
    }
}
