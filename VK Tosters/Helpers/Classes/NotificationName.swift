//
//  NotificationName.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let onLogin = Notification.Name(rawValue: "VK.Login")
    static let onLogout = Notification.Name(rawValue: "VK.Logout")
    static let onChangeSessionState = Notification.Name(rawValue: "VK.Session.Changed")
    static let onMessagesUpdate = Notification.Name(rawValue: "VK.Messages.Update")
    static let onFriendOnline = Notification.Name(rawValue: "VK.Friends.Online")
    static let onFriendOffline = Notification.Name(rawValue: "VK.Friends.Offline")
}
