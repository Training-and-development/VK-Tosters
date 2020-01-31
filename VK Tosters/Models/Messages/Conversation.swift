//
//  Conversation.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Conversation: NSObject {
    var peer: Peer = Peer()
    var inRead: Int = 0
    var outRead: Int = 0
    var unreadCount: Int = 0
    var isImportant: Bool = false
    var isUnanswered: Bool = false
    var canWrite: Writing = Writing()
    var chatSettings: ChatSettings = ChatSettings()
    
    convenience init(JSON: JSON) {
        self.init()
        self.peer = Peer(json: JSON["conversation"]["peer"])
        self.inRead = JSON["conversation"]["in_read"].intValue
        self.outRead = JSON["conversation"]["out_read"].intValue
        self.unreadCount = JSON["conversation"]["unread_count"].intValue
        self.isImportant = JSON["conversation"]["important"].boolValue
        self.isUnanswered = JSON["conversation"]["unanswered"].boolValue
        self.canWrite = Writing(json: JSON["conversation"]["can_write"])
        self.chatSettings = ChatSettings(json: JSON["conversation"]["chat_settings"])
    }
}
