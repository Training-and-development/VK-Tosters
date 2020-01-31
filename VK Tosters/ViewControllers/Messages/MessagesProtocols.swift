//
//  MessagesProtocols.swift
//  VK Tosters
//
//  Created programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import SwiftyJSON

//MARK: Wireframe -
protocol MessagesWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol MessagesPresenterProtocol: class {
    func start()
    func onEvent(message: String, _ style: ToastStyle)
    func onLoaded()
    func onTapRead(index: IndexPath)
    func getConversation(indexPath: IndexPath) -> Conversation
    func getLastMessage(indexPath: IndexPath) -> LastMessage
    func getUser(indexPath: IndexPath) -> User
    func getMe() -> User
    func getMessagesCount() -> Int
    func getUnread() -> Int
}

//MARK: Interactor -
protocol MessagesInteractorProtocol: class {
    var presenter: MessagesPresenterProtocol?  { get set }
    var responseJSON: JSON { get }
    var usersJSON: [JSON] { get }
    var myUserJSON: JSON { get }
    var conversationsJSON: [JSON] { get }
    var unread: Int { get }
    func start()
    func readMessage(peerId: String)
}

//MARK: View -
protocol MessagesViewProtocol: class {
    var presenter: MessagesPresenterProtocol?  { get set }
    func getToast(message: String, _ style: ToastStyle)
    func reload()
}