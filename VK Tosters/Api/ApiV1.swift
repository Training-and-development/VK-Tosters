//
//  ApiV1.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation
import SwiftyVK
import SwiftyJSON

final class ApiV1 {
    class func authorize() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                NotificationCenter.default.post(name: NotificationName.shared.onLogin, object: nil)
                print("SwiftyVK: success authorize with", info)
            },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
            }
        )
    }
    
    class func logout() {
        VK.sessions.default.logOut()
        NotificationCenter.default.post(name: NotificationName.shared.onLogout, object: nil)
        print("SwiftyVK: LogOut")
    }
    
    class func captcha() {
        VK.API.Custom.method(name: "captcha.force")
            .onSuccess { print("SwiftyVK: captcha.force successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: captcha.force failed with \n \($0)") }
            .send()
    }
    
    class func validation() {
        VK.API.Custom.method(name: "account.testValidation")
            .onSuccess { print("SwiftyVK: account.testValidation successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: account.testValidation failed with \n \($0)") }
            .send()
    }
    
    class func usersGet(userId: String, fields: String) {
        VK.API.Users.get([
            .userId: userId,
            .fields: fields])
            .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
            .onSuccess { print("SwiftyVK: users.get successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: friends.get fail \n \($0)") }
            .send()
    }
    
    class func friendsGet(count: String, fields: String) {
        VK.API.Friends.get([
        .count: count,
        .fields: fields])
        .configure(with: Config.init(httpMethod: .POST, language: Language(rawValue: "ru")))
        .send()
    }
    
    class func uploadPhoto() {
        guard
            let pathToImage = Bundle.main.path(forResource: "testImage", ofType: "png"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: pathToImage))
            else {
                print("Can not find testImage.png")
                return
        }
        
        let media = Media.image(data: data, type: .png)
        
        VK.API.Upload.Photo.toWall(media, to: .user(id: "4680178"))
            .onSuccess { print("SwiftyVK: upload successed with \n \(JSON($0))") }
            .onError { print("SwiftyVK: upload failed with \n \($0)")}
            .onProgress { print($0) }
            .send()
    }
    
    class func share() {
        guard #available(iOS 8.0, macOS 10.11, *) else {
            print("Sharing available only on iOS 8.0+ and macOS 10.11+")
            return
        }
        
        guard
            let pathToImage = Bundle.main.path(forResource: "testImage", ofType: "png"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: pathToImage)),
            let link = URL(string: "https://en.wikipedia.org/wiki/Hyperspace")
            else {
                print("Can not find testImage.png")
                return
        }
        
        VK.sessions.default.share(
            ShareContext(
                text: "This post made with #SwiftyVK 🖖🏽",
                images: [
                    ShareImage(data: data, type: .jpg),
                    ShareImage(data: data, type: .jpg),
                    ShareImage(data: data, type: .jpg),
                ],
                link: ShareLink(
                    title: "Follow the white rabbit",
                    url: link
                )
            ),
            onSuccess: { print("SwiftyVK: successfully shared with \n \(JSON($0))") },
            onError: { print("SwiftyVK: share failed with \n \($0)") }
        )
    }
}
