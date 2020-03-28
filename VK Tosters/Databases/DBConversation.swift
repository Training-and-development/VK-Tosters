//
//  Message.swift
//  VK Tosters
//
//  Created by programmist_np on 02/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

@objcMembers class DBConversation: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var localId: Int = 0
    @objc dynamic var lastMessageId: Int = 0
    @objc dynamic var inRead: Int = 0
    @objc dynamic var outRead: Int = 0
    @objc dynamic var unreadCount: Int = 0
    @objc dynamic var canWriteAllowed: Bool = false
    
    convenience init(conversation: JSON) {
        self.init()
        self.id = conversation["peer"]["id"].intValue
        self.type = conversation["peer"]["type"].stringValue
        self.localId = conversation["peer"]["local_id"].intValue
        self.lastMessageId = conversation["last_message_id"].intValue
        self.inRead = conversation["in_read"].intValue
        self.outRead = conversation["out_read"].intValue
        self.unreadCount = conversation["unread_count"].intValue
        self.canWriteAllowed = conversation["can_write"]["allowed"].boolValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers class DBLastMessage: Object, Codable {
    @objc dynamic var date: String = "0"
    @objc dynamic var fromId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var out: Int = 0
    @objc dynamic var peerId: Int = 0
    @objc dynamic var text: String = "0"
    @objc dynamic var conversationMessageId: Int = 0
    @objc dynamic var isImportant: Bool = false
    @objc dynamic var randomId: Int = 0
    
    convenience init(lastMessage: JSON) {
        self.init()
        self.date = ConversationCore.messageTime(time: lastMessage["date"].intValue)
        self.fromId = lastMessage["from_id"].intValue
        self.id = lastMessage["id"].intValue
        self.out = lastMessage["out"].intValue
        self.peerId = lastMessage["peer_id"].intValue
        self.text = lastMessage["text"].stringValue
        self.conversationMessageId = lastMessage["conversation_message_id"].intValue
        self.isImportant = lastMessage["important"].boolValue
        self.randomId = lastMessage["random_id"].intValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
