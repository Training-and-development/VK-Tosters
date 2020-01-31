//
//  Attachments.swift
//  VK Tosters
//
//  Created by programmist_np on 31/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Attachments: NSObject {
    var type: String = ""
    
    convenience init(json: [JSON]) {
        self.init()
        for array in json {
            self.type = typeAttachment(string: array["type"].stringValue)
        }
    }
    
    func typeAttachment(string: String) -> String {
        switch string {
        case "photo":
            return "Фотография"
        case "video":
            return "Видеозапись"
        case "audio":
            return "Аудиозапись"
        case "audio_message":
            return "Голосовое сообщение"
        case "doc":
            return "Документ"
        case "link":
            return "Ссылка"
        case "market":
            return "Товар"
        case "market_album":
            return "Подборка товаров"
        case "wall":
            return "Запись на стене"
        case "wall_reply":
            return "Комментарий к записи"
        case "sticker":
            return "Стикер"
        case "gift":
            return "Подарок"
        default: return ""
        }
    }
}
