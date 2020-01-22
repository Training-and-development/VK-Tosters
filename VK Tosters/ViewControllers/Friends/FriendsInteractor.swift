//
//  FriendsInteractor.swift
//  VK Tosters
//
//  Created programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import UIKit
import SwiftyVK
import SwiftyJSON

class FriendsInteractor: FriendsInteractorProtocol {
    weak var presenter: FriendsPresenterProtocol?
    var friendsJSON: [JSON] = []
    var responseJSON: JSON = []
    
    
    func start() {
        VK.API.Friends.get([.count: String(50), .fields: ApiFriendsFields.getFriendsField])
            .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
            .onSuccess { response in
                self.responseJSON = JSON(response)
                self.friendsJSON = self.responseJSON[ApiFriendsResponse.items].arrayValue
                self.handleResponse(response: self.responseJSON)
                ResponseState.isLoaded = true
                DispatchQueue.main.async {
                    self.presenter?.onEvent(message: "Success", .default)
                }
        }
        .onError { error in
            ResponseState.isLoaded = false
            DispatchQueue.main.async {
                self.presenter?.onEvent(message: "Error", .error)
            }
        }
        .send()
    }
    
    func handleResponse(response: JSON) {
        DispatchQueue.main.async {
            let mapItems = self.friendsJSON.map { Friend(json: $0) }
            self.presenter?.onLoadData()
        }
    }
}
