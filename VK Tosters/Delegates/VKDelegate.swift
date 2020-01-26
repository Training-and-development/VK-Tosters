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
    let scopes: Scopes = [.offline,.friends,.wall,.photos,.audio,.video,.docs,.market,.email]
    var profile: JSON = JSON()

    init() {
        VK.setUp(appId: VKConstants.shared.appId, delegate: self)
        let state = VK.sessions.default.state
        guard state == .authorized else { return }
        startLongPollServer()
        getMe()
    }
    
    func startLongPollServer() {
        VK.sessions.default.longPoll.start(version: LongPollVersion.third) {
            for event in $0 {
                switch event {
                    case let .type1(data):
                        let json = JSON(data)
                        print(json)
                    default:
                        break
                }
            }
        }
    }
    
    func getMe() {
        VK.API.Account.getProfileInfo(.empty)
            .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
            .onSuccess { response in
                self.profile = JSON(response)
                DispatchQueue.main.async {
                    let profileModel = Profile(json: self.profile)
                    print(profileModel)
                }
        }
        .onError { error in
            print(error)
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
                rootController.modalPresentationStyle = .fullScreen
                rootController.present(viewController, animated: true, completion: nil)
            }
        } else {
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                rootController.view.backgroundColor = .clear
                rootController.modalPresentationStyle = .fullScreen
                rootController.present(viewController, animated: true, completion: nil)
            }
        }
    }

    func vkTokenCreated(for sessionId: String, info: [String : String]) {
      print("token created in session \(sessionId) with info \(info)")
    }

    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
      print("token created in session \(sessionId) with info \(info)")
    }

    func vkTokenRemoved(for sessionId: String) {
      print("token removed in session \(sessionId)")
    }
}
