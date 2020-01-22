//
//  FriendsViewController.swift
//  VK Tosters
//
//  Created programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FriendsViewController: UIViewController, FriendsViewProtocol {
    @IBOutlet weak var mainTable: UITableView!

	var presenter: FriendsPresenterProtocol?
    let toaster = UIToaster()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        FriendsRouter.createModule(viewController: self)
        presenter?.start()
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
    }
    
    func showToast(message: String, _ style: ToastStyle) {
        toaster.show(view: self.view, style: style, message: message, duration: 1)
    }
}
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.setupConstrints()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
