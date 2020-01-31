//
//  Photo.swift
//  VK Tosters
//
//  Created by programmist_np on 28/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: NSObject {
    var id: Int = 0
    var albumId: Int = 0
    var ownerId: Int = 0
    var userId: Int = 0
    var text: String = ""
    var date: Int = 0
    var sizes: Sizes = Sizes()
    var width: Int = 0
    var height: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.albumId = json["album_id"].intValue
        self.ownerId = json["owner_id"].intValue
        self.userId = json["user_id"].intValue
        self.text = json["text"].stringValue
        self.date = json["date"].intValue
        self.sizes = Sizes(JSON: json["sizes"][2])
        self.width = json["width"].intValue
        self.height = json["height"].intValue
    }
}

