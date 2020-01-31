//
//  Profile.swift
//  VK Tosters
//
//  Created by programmist_np on 25/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Profile: NSObject {
    var name: String = ""
    var maidenName: String? = ""
    var screenName: String = ""
    var sex: Int = 0
    var relation: Int = 0
    var relationPartnerModel: User = User()
    var relationPending: Int = 0
    var bdate: String = ""
    var bdateVisibility: Int = 0
    var homeTown: String = ""
    var countryModel: Country = Country()
    var cityModel: City = City()
    var status: String = ""
    var phone: String = ""
    
    convenience init(json: JSON) {
        self.init()
        self.name = "\(json["first_name"].stringValue) \(json["last_name"].stringValue)"
        self.maidenName = json["maiden_name"].stringValue
        self.screenName = json["screen_name"].stringValue
        self.sex = json["sex"].intValue
        self.relation = json["relation"].intValue
        self.relationPartnerModel = User(jsonRelationUser: json["relation_partner"])
        self.relationPending = json["relation_pending"].intValue
        self.bdate = json["bdate"].stringValue
        self.bdateVisibility = json["bdate_visibility"].intValue
        self.homeTown = json["home_town"].stringValue
        self.countryModel = Country(JSON: json["country"])
        self.cityModel = City(JSON: json["city"])
        self.status = json["status"].stringValue
        self.phone = json["phone"].stringValue
    }
}

