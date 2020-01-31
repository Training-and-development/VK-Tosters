//
//  MessagesRouter.swift
//  VK Tosters
//
//  Created programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MessagesRouter: MessagesWireframeProtocol {
    
    weak var viewController: MessagesViewProtocol?
    var baseViewController: UIViewController?
    
    class func createModule(viewController: MessagesViewController) {
        let interactor = MessagesInteractor()
        let router = MessagesRouter()
        let presenter = MessagesPresenter(interface: viewController, interactor: interactor, router: router)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.interactor = interactor
        router.baseViewController = viewController
    }
}
