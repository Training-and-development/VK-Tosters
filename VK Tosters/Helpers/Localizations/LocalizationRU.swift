//
//  LocalizationRU.swift
//  VK Tosters
//
//  Created by programmist_np on 22/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation

struct UserNameWithCase {
    static var name: String = ""
}

struct FriendsLocalization {
    static func getLastSeen(sex: Int, time: Date) -> String {
        let currentTime: NSNumber = NSNumber(value: Date().timeIntervalSince1970)
        let timestamp: NSNumber = NSNumber(value: time.timeIntervalSince1970)
        let seconds = timestamp.doubleValue
        let timestampDate = Date(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        if timestamp.doubleValue < currentTime.doubleValue - 86401 && timestamp.doubleValue > currentTime.doubleValue - 172802 {
            dateFormatter.dateFormat = "H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return sex == 1 ? "Была в сети вчера в \(formatDate)" : "Был в сети вчера в \(formatDate)"
        } else if timestamp.doubleValue < currentTime.doubleValue - 172802 {
            dateFormatter.dateFormat = "d MMMM в H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return sex == 1 ? "Была в сети \(formatDate)" : "Был в сети \(formatDate)"
        } else {
            dateFormatter.dateFormat = "H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return sex == 1 ? "Была в сети в \(formatDate)" : "Был в сети в \(formatDate)"
        }
    }
    
    static func getDeactivateState(deactivate: String) -> String {
        switch deactivate {
        case "deleted": return "Страница пользователя удалена"

        case "banned": return "Пользователь заблокирован"

        default: return ""
        }
    }
}
struct CommonLocalization {
    static let connected: String = "Подключено"
    static let notConnected: String = "Нет подключения к интернету"
}
