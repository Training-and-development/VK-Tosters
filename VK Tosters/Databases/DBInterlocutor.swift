//
//  DBUser.swift
//  VK Tosters
//
//  Created by programmist_np on 02/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers class DBUser: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var isClosed: Bool = false
    @objc dynamic var canAccessClosed: Bool = false
    @objc dynamic var sex: Int = 0
    @objc dynamic var screenName: String = ""
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var deactivate: String? = ""

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
        case deactivate
    }

    convenience init(user: JSON) {
        self.init()
        self.id = user["id"].intValue
        self.firstName = user["first_name"].stringValue
        self.lastName = user["last_name"].stringValue
        self.isClosed = user["is_closed"].boolValue
        self.canAccessClosed = user["can_access_closed"].boolValue
        self.sex = user["id"].intValue
        self.screenName = user["screen_name"].stringValue
        self.photo50 = user["photo_50"].stringValue
        self.photo100 = user["photo_100"].stringValue
        self.online = user["id"].intValue
        self.deactivate = user["deactivated"].string
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers class DBGroup: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Bool = false
    @objc dynamic var type: String = ""
    @objc dynamic var isAdmin: Int = 0
    @objc dynamic var adminLevel: Int = 0
    @objc dynamic var isMember: Int = 0
    @objc dynamic var isAdvertiser: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case adminLevel = "admin_level"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }

    convenience init(group: JSON) {
        self.init()
        self.id = group["id"].intValue
        self.name = group["name"].stringValue
        self.screenName = group["screen_name"].stringValue
        self.isClosed = group["is_closed"].boolValue
        self.type = group["type"].stringValue
        self.isAdmin = group["is_admin"].intValue
        self.adminLevel = group["admin_level"].intValue
        self.isMember = group["is_member"].intValue
        self.isAdvertiser = group["is_advertiser"].intValue
        self.photo50 = group["photo_50"].stringValue
        self.photo100 = group["photo_100"].stringValue
        self.photo200 = group["photo_200"].stringValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

