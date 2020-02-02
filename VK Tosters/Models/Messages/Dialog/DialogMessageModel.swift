//
//  DialogMessageModel.swift
//  VK Tosters
//
//  Created by programmist_np on 01/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class DialogMessageModel: NSObject {
    var date: Int = 0
    var fromId: Int = 0
    var id: Int = 0
    var out: Int = 0
    var peerId: Int = 0
    var text: String = ""
    var conversationMessageId: Int = 0
    var isImportant: Bool = false
    var attachments: Attachments = Attachments()
    var isHidden: Bool = false
    
    convenience init(json: JSON) {
        self.init()
        self.date = json["date"].intValue
        self.fromId = json["from_id"].intValue
        self.id = json["id"].intValue
        self.out = json["out"].intValue
        self.peerId = json["peer_id"].intValue
        self.text = json["text"].stringValue
        self.conversationMessageId = json["conversation_message_id"].intValue
        self.isImportant = json["important"].boolValue
        self.attachments = Attachments(json: json["attachments"].arrayValue)
        self.isHidden = json["is_hidden"].boolValue
    }
}
