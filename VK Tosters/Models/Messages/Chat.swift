//
//  Chat.swift
//  VK Tosters
//
//  Created by programmist_np on 06/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Chat: NSObject {
    var id: Int = 0
    var type: String = ""
    var title: String = ""
    var adminId: Int = 0
    var membersCount: Int = 0
    var users: [Int] = []
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.type = json["type"].stringValue
        self.title = json["title"].stringValue
        self.adminId = json["admin_id"].intValue
        self.membersCount = json["members_count"].intValue
        self.users = [json["users"].intValue]
    }
}
