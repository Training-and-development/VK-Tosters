//
//  FriendsPresenter.swift
//  VK Tosters
//
//  Created programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

struct ResponseState {
    static var isLoaded: Bool = false
}

class FriendsPresenter: FriendsPresenterProtocol {
    weak private var view: FriendsViewProtocol?
    var interactor: FriendsInteractorProtocol?
    private let router: FriendsWireframeProtocol

    init(interface: FriendsViewProtocol, interactor: FriendsInteractorProtocol?, router: FriendsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    deinit {
        ResponseState.isLoaded = false
        print("FriendsPresenter deinited")
    }

    func start() {
        interactor?.start()
    }
    
    func onEvent(message: String, _ style: ToastStyle) {
        view?.getToast(message: message, style)
    }
    
    func onLoadData() {
        view?.reloadTableView()
    }
    
    func onTapUser(indexPath: IndexPath) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            self.interactor?.getNameWithCase(nameCase: .gen, userId: self.getFriend(indexPath: indexPath).id, completionHandler: { success in
                guard success else { return() }
                DispatchQueue.main.async {
                    self.router.openProfile(userId: self.getFriend(indexPath: indexPath).id, nameWithGenCase: UserNameWithCase.name)
                }
                return()
            })
        }
    }
    
    func onSwipeUser(indexPath: IndexPath, completion: DeleteFriendCompletionHandler?) {
        interactor?.deleteFriendsRequest(userId: getFriend(indexPath: indexPath).id, completionHandler: { success in
            if success {
                self.view?.getToast(message: "Вы удалили \(UserNameWithCase.name)", .success)
                completion?(true)
            } else {
                self.view?.getToast(message: "Произошла ошибка", .error)
                completion?(false)
            }
            return ()
        })
    }
    
    func getFriend(indexPath: IndexPath) -> Friend {
        let friendJSON = interactor?.friendsJSON[indexPath.row]
        let friend = friendJSON.map { Friend(json: $0) }
        return friend!
    }
    
    func getFriendsCount() -> Int {
        return interactor!.friendsJSON.count
    }
    
    func getName(nameCase: NameCases, indexPath: IndexPath) {
        interactor?.getNameWithCase(nameCase: nameCase, userId: getFriend(indexPath: indexPath).id, completionHandler: { success in
            if success {
                DispatchQueue.main.async {
                    self.view?.openPopup(headerText: "Удаление из друзей", descriptionText: "Действительно удалить \(UserNameWithCase.name) из друзей?", confrimText: "Да", declineText: "Отмена")
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.getToast(message: CommonLocalization.notConnected, .error)
                }
            }
            return ()
        })
    }
}
