//
//  ConversationCore.swift
//  VK Tosters
//
//  Created by programmist_np on 03/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class ConversationCore: NSObject {
    // Переписка
    var id: Int = 0
    var type: String = ""
    var localId: Int = 0
    var lastMessageId: Int = 0
    var inRead: Int = 0
    var outRead: Int = 0
    var unreadCount: Int = 0
    var isImportantConversation: Bool = false
    var isUnanswered: Bool = false
    var isAllowed: Bool = false
    var reason: Int = 0
    var membersCount: Int = 0
    var title: String = ""
    var state: String = ""
    var photo: Photo = Photo()
    var activeIds: [Int] = []
    var isGroupChannel: Bool = false
    // Последнее сообщение
    var idLastMessage: Int = 0
    var date: Int = 0
    var parsingTime: String = ""
    var peerId: Int = 0
    var fromId: Int = 0
    var text: String = ""
    var randomId: Int = 0
    var isImportantLastMessage: Bool = false
    var attachments: Attachments = Attachments()
    // Пользователь
    var userId: String = ""
    var userName: String = ""
    var online: Int = 0
    var lastSeen: LastSeen = LastSeen()
    var photo100: String = ""
    // Пользователь - отправитель
    var senderUserId: String = ""
    var senderUserName: String = ""
    var senderOnline: Int = 0
    var senderPhoto100: String = ""
    
    convenience init(JSON: JSON) {
        self.init()
        // Переписка
        self.id = JSON["conversation"]["peer"]["id"].intValue
        self.type = JSON["conversation"]["peer"]["type"].stringValue
        self.localId = JSON["conversation"]["peer"]["local_id"].intValue
        self.lastMessageId = JSON["last_message_id"].intValue
        self.inRead = JSON["conversation"]["in_read"].intValue
        self.outRead = JSON["conversation"]["out_read"].intValue
        self.unreadCount = JSON["conversation"]["unread_count"].intValue
        self.isImportantConversation = JSON["conversation"]["important"].boolValue
        self.isUnanswered = JSON["conversation"]["unanswered"].boolValue
        self.isAllowed = JSON["conversation"]["can_write"]["allowed"].boolValue
        self.reason = JSON["conversation"]["can_write"]["reason"].intValue
        self.membersCount = JSON["conversation"]["chat_settings"]["members_count"].intValue
        self.title = JSON["conversation"]["chat_settings"]["title"].stringValue
        self.state = JSON["conversation"]["chat_settings"]["state"].stringValue
        self.photo = Photo(json: JSON["conversation"]["chat_settings"]["photo"])
        self.activeIds = [JSON["conversation"]["chat_settings"]["active_ids"].intValue]
        self.isGroupChannel = JSON["conversation"]["chat_settings"]["is_group_channel"].boolValue
        // Последнее сообщение
        self.idLastMessage = JSON["last_message"]["id"].intValue
        self.date = JSON["last_message"]["date"].intValue
        self.parsingTime = messageTime(time: JSON["last_message"]["date"].intValue)
        self.peerId = JSON["last_message"]["peer_id"].intValue
        self.fromId = JSON["last_message"]["from_id"].intValue
        self.text = JSON["last_message"]["text"].stringValue
        self.randomId = JSON["last_message"]["random_id"].intValue
        self.isImportantLastMessage = JSON["last_message"]["important"].boolValue
        self.attachments = Attachments(json: JSON["last_message"]["attachments"].arrayValue)
        // Пользователь
        self.userId = JSON["profile"]["id"].stringValue
        self.userName = "\(JSON["profile"]["first_name"].stringValue) \(JSON["profile"]["last_name"].stringValue)"
        self.online = JSON["profile"]["online"].intValue
        self.lastSeen = LastSeen(json: JSON["profile"]["last_seen"])
        self.photo100 = JSON["profile"]["photo_100"].stringValue
        // Пользователь - отправитель
        self.senderUserId = MyData.userId
        self.senderUserName = MyData.userName
        self.senderOnline = MyData.online
        self.senderPhoto100 = MyData.photo
    }
    
    func messageTime(time: Int) -> String {
        let currentTime: NSNumber = NSNumber(value: Date().timeIntervalSince1970)
        let date = Date(timeIntervalSince1970: Double(time))
        let timestamp: NSNumber = NSNumber(value: date.timeIntervalSince1970)
        let seconds = timestamp.doubleValue
        let timestampDate = Date(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let calendar = Calendar.current
        let yearWithTime = calendar.component(.year, from: date)
        let yearReal = calendar.component(.year, from: Date())
        
        if timestamp.doubleValue < currentTime.doubleValue && timestamp.doubleValue > currentTime.doubleValue - 86401 {
            dateFormatter.dateFormat = "H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else if timestamp.doubleValue < currentTime.doubleValue - 86401 && timestamp.doubleValue > currentTime.doubleValue - 172802 {
            return "Вчера"
        } else if timestamp.doubleValue < currentTime.doubleValue - 172802 && yearReal == yearWithTime {
            dateFormatter.dateFormat = "d MMM"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else if yearReal > yearWithTime {
            dateFormatter.dateFormat = "d.M.YYYY"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else {
            dateFormatter.dateFormat = "d.M.YYYY"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        }
    }
}
