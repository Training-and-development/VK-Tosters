//
//  MessageService.swift
//  VK Tosters
//
//  Created by programmist_np on 02/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import RealmSwift

class MessageService {
    static let shared = MessageService()
    
    func getDBConversation(conversation: ConversationCore) -> DBConversation? {
        guard conversation.id != 0 else { return nil }
        let realm = try! Realm()
        let messages = realm.objects(DBConversation.self).filter("id = %@", conversation.id)
        
        if let newConversation = messages.first {
            return newConversation
        } else {
            let newConversation = DBConversation()
            newConversation.id = conversation.id
            newConversation.type = conversation.type
            newConversation.localId = conversation.localId
            newConversation.lastMessageId = conversation.lastMessageId
            newConversation.inRead = conversation.inRead
            newConversation.outRead = conversation.outRead
            newConversation.unreadCount = conversation.unreadCount
            newConversation.isImportantConversation = conversation.isImportantConversation
            newConversation.isUnanswered = conversation.isUnanswered
            newConversation.isAllowed = conversation.isAllowed
            newConversation.reason = conversation.reason
            newConversation.membersCount = conversation.membersCount
            newConversation.title = conversation.title
            newConversation.state = conversation.state
            newConversation.photo = conversation.photo
            newConversation.activeIds = conversation.activeIds
            newConversation.isGroupChannel = conversation.isGroupChannel
            newConversation.idLastMessage = conversation.idLastMessage
            newConversation.date = conversation.date
            newConversation.parsingTime = conversation.parsingTime
            newConversation.fromId = conversation.fromId
            newConversation.text = conversation.text
            newConversation.randomId = conversation.randomId
            newConversation.isImportantLastMessage = conversation.isImportantLastMessage
            newConversation.attachments = conversation.attachments
            newConversation.userId = conversation.userId
            newConversation.userName = conversation.userName
            newConversation.online = conversation.online
            newConversation.lastSeen = conversation.lastSeen
            newConversation.photo100 = conversation.photo100
            newConversation.senderUserId = conversation.senderUserId
            newConversation.senderUserName = conversation.senderUserName
            newConversation.senderOnline = conversation.senderOnline
            newConversation.senderPhoto100 = conversation.senderPhoto100
            
            try! realm.write {
                realm.add(newConversation)
            }
            return newConversation
        }
    }
    
    func getDBUser(user: User) -> DBUser? {
        guard user.id != "" else { return nil }
        let realm = try! Realm()
        let users = realm.objects(DBUser.self).filter("id = %@", user.id)
        
        if let newUser = users.first {
            try! realm.write {
                newUser.name = user.name
                newUser.screenName = user.screenName
                newUser.isClosed = user.isClosed
                newUser.canAccessClosed = user.canAccessClosed
                newUser.sex = user.sex
                newUser.online = user.online
                newUser.deactivated = user.deactivated
                newUser.lastSeen = user.lastSeen
                newUser.online = user.online
                newUser.deactivated = user.deactivated
                newUser.photoOriginal = user.photoOriginal
                newUser.photo100 = user.photo100
                newUser.counters = user.counters
                newUser.friendStatus = user.friendStatus
            }
            return newUser
        } else {
            let newUser = DBUser()
            newUser.id = user.id
            newUser.name = user.name
            newUser.screenName = user.screenName
            newUser.isClosed = user.isClosed
            newUser.canAccessClosed = user.canAccessClosed
            newUser.sex = user.sex
            newUser.online = user.online
            newUser.deactivated = user.deactivated
            newUser.lastSeen = user.lastSeen
            newUser.online = user.online
            newUser.deactivated = user.deactivated
            newUser.photoOriginal = user.photoOriginal
            newUser.photo100 = user.photo100
            newUser.counters = user.counters
            newUser.friendStatus = user.friendStatus
            
            try! realm.write {
                realm.add(newUser)
            }
            return newUser
        }
    }
}
