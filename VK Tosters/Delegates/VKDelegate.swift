//
//  VKDelegate.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyVK
import SwiftyJSON
import UIKit

struct MyData {
    static var photo: String = ""
    static var userName: String = ""
    static var online: Int = 0
    static var sex: Int = 0
    static var userId: String = ""
}

class VKDelegate: SwiftyVKDelegate {
    let scopes: Scopes = [.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email, .notifications]
    let defaults = UserDefaults.standard

    init() {
        VK.setUp(appId: VKConstants.shared.appId, delegate: self)
        let state = VK.sessions.default.state
        guard state == .authorized else { return }
        setObservers()
        startLongPollServer()
        getMe()
    }
    
    func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func startLongPollServer() {
        VK.sessions.default.longPoll.start(version: LongPollVersion.third) {
            for event in $0 {
                switch event {
                case let .type1(data):
                    let json = JSON(data)
                    print("type1",json)
                case let .type2(data: data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onMessagesRemoved, object: nil, userInfo: userInfo)
                    print("type2",json)
                case let .type3(data):
                    let json = JSON(data)
                    print("type3",json)
                case let .type4(data: data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onMessagesReceived, object: nil, userInfo: userInfo)
                    print("type4",json)
                case let .type5(data):
                    let json = JSON(data)
                    print("type5",json)
                case let .type6(data: data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onInMessagesRead, object: nil, userInfo: userInfo)
                    print("type6",json)
                case let .type7(data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onOutMessagesRead, object: nil, userInfo: userInfo)
                    print("type7",json)
                case let .type8(data: data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onFriendOnline, object: nil, userInfo: userInfo)
                    print("type8",json)
                case let .type9(data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onFriendOffline, object: nil, userInfo: userInfo)
                    print("type9",json)
                case let .type10(data: data):
                    let json = JSON(data)
                    print("type10",json)
                case let .type11(data):
                    let json = JSON(data)
                    print("type11",json)
                case let .type12(data: data):
                    let json = JSON(data)
                    print("type12",json)
                case let .type13(data):
                    let json = JSON(data)
                    print("type13",json)
                case let .type14(data: data):
                    let json = JSON(data)
                    print("type14",json)
                case let .type51(data):
                    let json = JSON(data)
                    print("type51",json)
                case let .type52(data: data):
                    let json = JSON(data)
                    print("type52",json)
                case let .type61(data):
                    let json = JSON(data)
                    print("type61",json)
                case let .type62(data: data):
                    let json = JSON(data)
                    print("type62",json)
                case let .type70(data):
                    let json = JSON(data)
                    print("type70",json)
                case let .type80(data: data):
                    let json = JSON(data)
                    print("type80",json)
                case let .type114(data):
                    let json = JSON(data)
                    print("type114",json)
                default:
                    break
                }
            }
        }
    }
    
    func getMe() {
        VK.API.Users.get([.fields: ApiUsersFields.getUsersField])
            .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
            .onSuccess { response in
                let responseJSON = JSON(response).arrayValue
                let myUser = responseJSON.map { User(jsonFullUser: $0) }
                MyData.photo = myUser[0].photo100
                MyData.userName = myUser[0].name
                MyData.online = myUser[0].online
                MyData.sex = myUser[0].sex
                MyData.userId = myUser[0].id
        }
        .onError { error in
            print(String(describing: error))
        }
        .send()
    }
    
    open var markOnline: Void {
        get {
            VK.API.Account.setOnline([.voip: "0"]).send()
        }
    }
    
    open var markOffline: Void {
        get {
            VK.API.Account.setOffline(.empty).send()
        }
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
      return scopes
    }

    func vkNeedToPresent(viewController: VKViewController) {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            if let rootController = keyWindow?.rootViewController {
                rootController.view.backgroundColor = .clear
                rootController.modalPresentationStyle = .overCurrentContext
                rootController.present(viewController, animated: true, completion: nil)
            }
        } else {
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                rootController.view.backgroundColor = .clear
                rootController.modalPresentationStyle = .overCurrentContext
                rootController.present(viewController, animated: true, completion: nil)
            }
        }
    }

    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
        let myUserId = info["user_id"]
        defaults.set(myUserId, forKey: "userId")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
        let myUserId = info["user_id"]
        defaults.set(myUserId, forKey: "userId")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
        defaults.set("none", forKey: "userId")
    }
}
extension VKDelegate {
    @objc func onBackground(_ notification: Notification) {
        print("You are offline")
        self.markOffline
    }
    
    @objc func onActive(_ notification: Notification) {
        print("You are online")
        self.markOnline
    }
}
