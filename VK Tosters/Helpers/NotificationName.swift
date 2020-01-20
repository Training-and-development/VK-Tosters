//
//  NotificationName.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation

class NotificationName {
    static let shared = NotificationName()

    let onLogin = Notification.Name(rawValue: "VK.Login")
    let onLogout = Notification.Name(rawValue: "VK.Logout")
    let onChangeSessionState = Notification.Name(rawValue: "VK.SessionChanged")
}
