//
//  TabBarStartController.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import SwiftyJSON

class TabBarStartController: UITabBarController {
    var counts: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !UserDefaults.standard.string(forKey: "userId")!.contains("none") else {
            ApiV1.authorize()
            return
        }
        getCounters()
        getConversations()
    }
    
    func getCounters() {
        VK.API.Friends.getRequests([.out: "0"])
            .configure(with: Config.init(httpMethod: .GET, language: Language(rawValue: "ru")))
            .onSuccess { response in
                DispatchQueue.main.async {
                    autoreleasepool {
                        self.handleResponse(user: JSON(response))
                    }
                }
        }
        .onError { error in
            DispatchQueue.main.async {
                autoreleasepool {
                    self.handleResponse(user: nil)
                }
            }
        }
        .send()
    }
    
    func handleResponse(user: JSON?) {
        guard user?["count"].intValue != 0 else {
            self.tabBar.items![4].badgeValue = nil
            return
        }
        self.tabBar.items![4].badgeValue = "\(String(describing: user!["count"].intValue))"
    }
    
    func getConversations() {
        VK.API.Messages.getConversations([.count: "200", .filter: "unread"])
        .configure(with: Config.init(httpMethod: .GET, language: Language(rawValue: "ru")))
            .onSuccess { response in
                DispatchQueue.main.async {
                    autoreleasepool {
                        self.handleResponseMessages(user: JSON(response))
                    }
                }
        }
        .onError { error in
            DispatchQueue.main.async {
                autoreleasepool {
                    self.handleResponseMessages(user: nil)
                }
            }
        }
        .send()
    }
    
    func handleResponseMessages(user: JSON?) {
        guard user?["count"].intValue != 0 else {
            self.tabBar.items![2].badgeValue = nil
            return
        }
        self.tabBar.items![2].badgeValue = "\(String(describing: user!["unread_count"].intValue))"
    }
}
