//
//  LastMessage.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class LastMessage: NSObject {
    var id: Int = 0
    var date: Int = 0
    var peerId: Int = 0
    var fromId: Int = 0
    var text: String = ""
    var randomId: Int = 0
    var isImportant: Bool = false
    
    convenience init(JSON: JSON) {
        self.init()
        self.id = JSON["last_message"]["id"].intValue
        self.date = JSON["last_message"]["date"].intValue
        self.peerId = JSON["last_message"]["peer_id"].intValue
        self.fromId = JSON["last_message"]["from_id"].intValue
        self.text = JSON["last_message"]["text"].stringValue
        self.randomId = JSON["last_message"]["random_id"].intValue
        self.isImportant = JSON["last_message"]["important"].boolValue
    }
}
