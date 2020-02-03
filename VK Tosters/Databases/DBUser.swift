//
//  DBUser.swift
//  VK Tosters
//
//  Created by programmist_np on 02/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import RealmSwift

class DBUser: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Bool = false
    @objc dynamic var canAccessClosed: Bool = false
    @objc dynamic var sex: Int = 0
    @objc dynamic var online: Int = 0
    @objc dynamic var deactivated: String?
    var lastSeen: LastSeen = LastSeen()
    @objc dynamic var photoOriginal: String = ""
    @objc dynamic var photo100: String = ""
    var counters: Counters = Counters()
    @objc dynamic var friendStatus: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
