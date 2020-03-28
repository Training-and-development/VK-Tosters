//
//  Group.swift
//  VK Tosters
//
//  Created by programmist_np on 06/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: NSObject {
    var id: String = ""
    var name: String = ""
    var screenName: String = ""
    var isClosed: Bool = false
    var type: String = ""
    var isAdmin: Bool = false
    var isMember: Bool = false
    var isAdvertiser: Bool = false
    var deactivated: String?
    var photo50: String = ""
    var photo100: String = ""
    var photo200: String = ""
    
    convenience init(jsonFullUser: JSON) {
        self.init()
        self.id = jsonFullUser["id"].stringValue
        self.name = jsonFullUser["name"].stringValue
        self.screenName = jsonFullUser["screen_name"].stringValue
        self.isClosed = jsonFullUser["is_closed"].boolValue
        self.type = jsonFullUser["type"].stringValue
        self.isClosed = jsonFullUser["is_closed"].boolValue
        self.isMember = jsonFullUser["is_member"].boolValue
        self.isAdvertiser = jsonFullUser["is_advertiser"].boolValue
        self.deactivated = jsonFullUser["deactivated"].stringValue
        self.photo50 = jsonFullUser["photo_50"].stringValue
        self.photo100 = jsonFullUser["photo_100"].stringValue
        self.photo200 = jsonFullUser["photo_200"].stringValue
    }
}
