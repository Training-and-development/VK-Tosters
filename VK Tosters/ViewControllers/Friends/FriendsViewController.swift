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
    let footerView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 38))

	var presenter: FriendsPresenterProtocol?
    let toaster = UIToaster()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        FriendsRouter.createModule(viewController: self)
        presenter?.start()
        setupTable()
    }
    
    func setupTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        mainTable.register(UINib(nibName: "PlaceholderCell", bundle: nil), forCellReuseIdentifier: "PlaceholderCell")
        setupFooter()
    }
    
    func setupFooter() {
        footerView.numberOfLines = 0
        footerView.sizeToFit()
        footerView.textAlignment = .center
        footerView.font = UIFont(name: "Lato-Regular", size: 12)
        footerView.textColor = Colors.shared.metal
        mainTable.tableFooterView = footerView
        mainTable.tableFooterView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: -38, right: 0)
        mainTable.tableFooterView?.bounds.size.height = 38
    }
    
    func showToast(message: String, _ style: ToastStyle) {
        toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            self.toaster.hide(view: self.view, toast: self.toaster.toast, isNeedAnimation: false)
            self.toaster.show(view: self.view, style: style, message: message, duration: 1)
        })
    }
    
    func reloadTableView() {
        mainTable.reloadData()
    }
}
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard ResponseState.isLoaded else { return 50 }
        guard presenter != nil else { return 1 }
        footerView.text = "Количество друзей: \(presenter!.getFriendsCount())"
        return presenter!.getFriendsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard presenter != nil else { return UITableViewCell() }
        if ResponseState.isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
            cell.setup(model: presenter!.getFriend(indexPath: indexPath))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath) as! PlaceholderCell
            cell.setup()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard presenter != nil else { return }
        presenter?.onTapUser(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
