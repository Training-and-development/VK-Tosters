//
//  Counters.swift
//  VK Tosters
//
//  Created by programmist_np on 28/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON

class Counters: NSObject {
    var albums: Int = 0
    var videos: Int = 0
    var audios: Int = 0
    var photos: Int = 0
    var notes: Int = 0
    var friends: Int = 0
    var groups: Int = 0
    var onlineFriends: Int = 0
    var mutualFriends: Int = 0
    var userVideos: Int = 0
    var followers: Int = 0
    var pages: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.albums = json["albums"].intValue
        self.videos = json["videos"].intValue
        self.audios = json["audios"].intValue
        self.photos = json["photos"].intValue
        self.notes = json["notes"].intValue
        self.friends = json["friends"].intValue
        self.onlineFriends = json["online_friends"].intValue
        self.mutualFriends = json["mutual_friends"].intValue
        self.userVideos = json["user_videos"].intValue
        self.followers = json["followers"].intValue
        self.pages = json["pages"].intValue
    }
}
