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

class VKDelegate: SwiftyVKDelegate {
    let scopes: Scopes = [.messages, .offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    let defaults = UserDefaults.standard

    init() {
        VK.setUp(appId: VKConstants.shared.appId, delegate: self)
        let state = VK.sessions.default.state
        guard state == .authorized else { return }
        startLongPollServer()
        setOnline()
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
                    print("type2",json)
                case let .type3(data):
                    let json = JSON(data)
                    print("type3",json)
                case let .type4(data: data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onMessagesUpdate, object: nil, userInfo: userInfo)
                    print("type4",json)
                case let .type5(data):
                    let json = JSON(data)
                    print("type5",json)
                case let .type6(data: data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onMessagesUpdate, object: nil, userInfo: userInfo)
                    print("type6",json)
                case let .type7(data):
                    let json = JSON(data)
                    let userInfo: [AnyHashable: Any]? = ["updates": json]
                    NotificationCenter.default.post(name: .onMessagesUpdate, object: nil, userInfo: userInfo)
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
    
    func setOnline() {
        VK.API.Account.setOnline([.voip: "0"]).send()
    }
    
    func registerDevice(token: String) {
        VK.API.Account.registerDevice([.token: token,
                                       .deviceId: UIDevice.current.identifierForVendor?.uuidString,
                                       .deviceModel: UIDevice.current.model,
                                       .systemVersion: UIDevice.current.systemVersion])
            .onSuccess { response in
                print("Push notifications registered", JSON(response))
        }
        .onError { error in
            print("Push notifications not registered", error.localizedDescription)
        }
        .send()
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
        registerDevice(token: info["access_token"]!)
        let myUserId = info["user_id"]
        defaults.set(myUserId, forKey: "userId")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
        registerDevice(token: info["access_token"]!)
        let myUserId = info["user_id"]
        defaults.set(myUserId, forKey: "userId")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
        defaults.set("none", forKey: "userId")
    }
}
