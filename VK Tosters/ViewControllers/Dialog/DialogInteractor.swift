//
//  DialogInteractor.swift
//  VK Tosters
//
//  Created programmist_np on 01/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import SwiftyJSON
import SwiftyVK

class DialogInteractor: DialogInteractorProtocol {
    weak var presenter: DialogPresenterProtocol?
    var responseJSON: [JSON] = []
    var countJSON: Int = 0
    var dialogMessagesJSON: [JSON] = []
    var peerId: String = ""
    var randomId: Int64 = 0
    
    func start(userId: String) {
        getChatHistory(peerId: userId)
        peerId = userId
        startObservers()
    }
    
    func startObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .onMessagesUpdate, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .onFriendOffline, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateMessages(_:)), name: .onFriendOnline, object: nil)
    }
    
    func getChatHistory(peerId: String) {
        VK.API.Messages.getHistory([.peerId: peerId, .rev: "0", .count: "200"])
            .configure(with: Config.init(httpMethod: .GET,language: Language(rawValue: "ru")))
            .onSuccess { response in
                self.responseJSON = JSON(response)["items"].arrayValue
                self.countJSON = JSON(response)["count"].intValue
                self.handleHistory(response: self.responseJSON)
        }
        .onError { error in
            
        }
        .send()
    }
    
    func handleHistory(response: [JSON]) {
        dialogMessagesJSON = response
        DispatchQueue.main.async {
            self.presenter?.onLoaded()
        }
    }
    
    func sendMessage(message: String, peerId: String) {
        randomId = Int64.random(in: 0 ..< Int64.max)
        VK.API.Messages.send([.peerId: peerId, .randomId: "\(randomId)", .message: message])
            .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
            .onSuccess { _ in
                DispatchQueue.main.async {
                    self.presenter?.onLoaded()
                    self.presenter?.onSended()
                }
        }
            .onError { _ in
                DispatchQueue.main.async {
                    self.presenter?.onEvent(message: "Произошла ошибка при отправке", .error)
                }
        }
        .send()
    }
    
    @objc func updateMessages(_ notification: Notification) {
        DispatchQueue.global(qos: .utility).async {
            self.getChatHistory(peerId: self.peerId)
        }
    }
}
