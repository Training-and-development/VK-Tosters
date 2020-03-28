//
//  LocalizationRU.swift
//  VK Tosters
//
//  Created by programmist_np on 22/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation

struct VKLocalization {
    static func getLastSeen(sex: Int, time: Date?) -> String {
        let currentTime: NSNumber = NSNumber(value: Date().timeIntervalSince1970)
        let timestamp: NSNumber = NSNumber(value: time!.timeIntervalSince1970)
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

    static func messageTime(time: Int) -> String {
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
        let beforeDay: Double = NSNumber(value: Date().dayBefore.timeIntervalSince1970).doubleValue
        
        if timestamp.doubleValue < currentTime.doubleValue && timestamp.doubleValue > beforeDay {
            dateFormatter.dateFormat = "Сегодня в H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else if timestamp.doubleValue < beforeDay && timestamp.doubleValue > beforeDay * 2 {
            dateFormatter.dateFormat = "Вчера в H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else if timestamp.doubleValue < beforeDay * 2 && yearReal == yearWithTime {
            dateFormatter.dateFormat = "d MMMM в H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else if yearReal > yearWithTime {
            dateFormatter.dateFormat = "d MMMM YYYY в H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        } else {
            dateFormatter.dateFormat = "d MMMM YYYY в H:mm"
            let formatDate = dateFormatter.string(from: timestampDate)
            return formatDate
        }
    }
    
    static func getDeactivateState(deactivate: String?, hasShort: Bool) -> String {
        switch deactivate {
        case "deleted" where !hasShort: return "Страница пользователя удалена"
            
        case "deleted" where hasShort: return "покинул нас"

        case "banned" where !hasShort: return "Пользователь заблокирован"
        
        case "banned" where hasShort: return "бан нахуй"

        default: return ""
        }
    }
}
struct CommonLocalization {
    static let connected: String = "Вы снова онлайн"
    static let notConnected: String = "Он нам и нахуй не нужон, интернет ваш!"
    
    static func getTime(time: Date) -> String {
        let timestamp: NSNumber = NSNumber(value: time.timeIntervalSince1970)
        let seconds = timestamp.doubleValue
        let timestampDate = Date(timeIntervalSince1970: seconds)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "H:mm"
        let formatDate = dateFormatter.string(from: timestampDate)
        return formatDate
    }
}
struct CaseLocalize {
    static let freindsString: [String?] = ["друг", "друга", "друзей", nil]
    static let followersString: [String?] = ["подписчик", "подписчика", "подписчиков", nil]
    static let membersString: [String?] = ["участник", "участника", "участников", nil]
    static let pagesString: [String?] = ["интересная страница", "интересных страницы", "интересных страницы", nil]
    static let attachmentsString: [String?] = ["вложение", "вложения", "вложений", nil]
    static let docsString: [String?] = ["документ", "документа", "документов", nil]
}
struct TableViewLocalization {
    static let wallsCount: [String?] = ["запись", "записи", "записей", nil]
    static let friendsCount: [String?] = ["друг", "друга", "друзей", nil]
}
