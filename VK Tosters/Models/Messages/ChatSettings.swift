//
//  Chat.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class ChatSettings: NSObject {
    var membersCount: Int = 0
    var title: String = ""
    var state: String = ""
    var photo: Photo = Photo()
    var activeIds: [Int] = []
    var isGroupChannel: Bool = false
    
    convenience init(json: JSON) {
        self.init()
        self.membersCount = json["members_count"].intValue
        self.title = json["title"].stringValue
        self.state = json["state"].stringValue
        self.photo = Photo(json: json["photo"])
        self.activeIds = [json["active_ids"].intValue]
        self.isGroupChannel = json["is_group_channel"].boolValue
    }
}
