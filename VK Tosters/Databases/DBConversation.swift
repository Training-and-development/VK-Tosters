//
//  Message.swift
//  VK Tosters
//
//  Created by programmist_np on 02/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import RealmSwift

class DBConversation: Object {
    // Переписка
    @objc dynamic var id: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var localId: Int = 0
    @objc dynamic var lastMessageId: Int = 0
    @objc dynamic var inRead: Int = 0
    @objc dynamic var outRead: Int = 0
    @objc dynamic var unreadCount: Int = 0
    @objc dynamic var isImportantConversation: Bool = false
    @objc dynamic var isUnanswered: Bool = false
    @objc dynamic var isAllowed: Bool = false
    @objc dynamic var reason: Int = 0
    @objc dynamic var membersCount: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var state: String = ""
    var photo: Photo = Photo()
    @objc dynamic var activeIds: [Int] = []
    @objc dynamic var isGroupChannel: Bool = false
    // Последнее сообщение
    @objc dynamic var idLastMessage: Int = 0
    @objc dynamic var date: Int = 0
    @objc dynamic var parsingTime: String = ""
    @objc dynamic var peerId: Int = 0
    @objc dynamic var fromId: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var randomId: Int = 0
    @objc dynamic var isImportantLastMessage: Bool = false
    var attachments: Attachments = Attachments()
    // Пользователь
    @objc dynamic var userId: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var online: Int = 0
    var lastSeen: LastSeen = LastSeen()
    @objc dynamic var photo100: String = ""
    // Пользователь - отправитель
    @objc dynamic var senderUserId: String = ""
    @objc dynamic var senderUserName: String = ""
    @objc dynamic var senderOnline: Int = 0
    @objc dynamic var senderPhoto100: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
