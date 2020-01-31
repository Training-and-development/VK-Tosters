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

struct SavedVariables {
    static var indexPath: IndexPath?
    static var userIdsFriendsViewController: [String] = []
    static var userIdsProfileViewController: [String] = []
}

class FriendsViewController: BaseViewController, FriendsViewProtocol {
    @IBOutlet weak var backViewButton: UIButton!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var friendsTitleLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var toolbarView: UIView!
    @IBOutlet weak var dividerSegmentView: UIView!
    @IBOutlet weak var dividerSegmentHeight: NSLayoutConstraint!
    @IBOutlet weak var segmentBlur: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let footerView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 38))
    let errorView = ErrorView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 24, height: 97)))
    let preloaderView = LoadingView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 24, height: 72)))

    lazy var refreshControl = UIRefreshControl()
    
    fileprivate var statusBarShouldLight = true
    static var userId: String = ""
    
    static var usersIds: [String] = []

	var presenter: FriendsPresenterProtocol?
    let searchController = UISearchController(searchResultsController: nil)
    
	override func viewDidLoad() {
        super.viewDidLoad()
        FriendsRouter.createModule(viewController: self)
        SavedVariables.userIdsFriendsViewController.append(FriendsViewController.userId)
        presenter?.start(userId: SavedVariables.userIdsFriendsViewController.last ?? "")
        refreshControl = UIRefreshControl()
        setupTable()
        setupSearch()
        setupError()
        setupPreloader()
        setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.hidesNavigationBarDuringPresentation = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchController.hidesNavigationBarDuringPresentation = false
        if isMovingFromParent {
            guard SavedVariables.userIdsFriendsViewController != [] else { return }
            SavedVariables.userIdsFriendsViewController.removeLast()
        }
    }
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.frame = CGRect(origin: .zero, size: .zero)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        friendsTitleLabel.text = "Друзья"
        friendsTitleLabel.font = UIFont(name: "Lato-Bold", size: 20)
        friendsTitleLabel.textColor = .toasterBlack
        backViewButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backViewButton.tintColor = .toasterBlue
        dividerView.autoSetDimension(.height, toSize: 0.5)
        dividerView.backgroundColor = .toasterMetal
        dividerSegmentHeight.constant = 0.5
        dividerSegmentView.backgroundColor = .toasterDarkGray
        segmentBlur.blurry()
    }
    
    func setupTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.contentInset = UIEdgeInsets(top: 52, left: 0, bottom: 55, right: 0)
        mainTable.backgroundColor = .toasterWhite
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        mainTable.addSubview(refreshControl)
        mainTable.keyboardDismissMode = .onDrag
        mainTable.allowsMultipleSelectionDuringEditing = true
        mainTable.tableHeaderView = searchController.searchBar
        mainTable.register(UINib(nibName: "FriendCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        self.navigationController?.navigationItem.titleView = preloaderView
        setupFooter()
    }
    
    func setupSearch() {
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.setCenteredPlaceHolder()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.searchTextField.font = UIFont(name: "Lato-Regular", size: 15)
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        setSearchFieldBackgroundColor(.toasterLightGray)
    }
    
    private func setSearchFieldBackgroundColor(_ searchFieldBackgroundColor: UIColor) {
        let patternSize = CGSize(width: 32, height: 32)
        
        let imagePattern = UIImage.imageWithColor(searchFieldBackgroundColor, imageSize: patternSize)
        let roundedImagePattern = imagePattern.flatMap { UIImage.roundedImage($0, cornerRadius: patternSize.height / 2) }
        
        if let roundedImagePattern = roundedImagePattern {
            searchController.searchBar.setSearchFieldBackgroundImage(roundedImagePattern, for: .normal)
        }
    }
    
    func setupFooter() {
        footerView.numberOfLines = 0
        footerView.sizeToFit()
        footerView.textAlignment = .center
        footerView.font = UIFont(name: "Lato-Regular", size: 12)
        footerView.textColor = .toasterMetal
        mainTable.tableFooterView = footerView
        mainTable.tableFooterView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: -38, right: 0)
        mainTable.tableFooterView?.bounds.size.height = 38
    }
    
    func setupError() {
        self.view.addSubview(errorView)
        errorView.autoAlignAxis(toSuperviewAxis: .vertical)
        errorView.autoAlignAxis(toSuperviewAxis: .horizontal)
        errorView.setup()
        errorView.isHidden = true
    }
    
    func setupPreloader() {
        self.view.addSubview(preloaderView)
        preloaderView.autoAlignAxis(toSuperviewAxis: .vertical)
        preloaderView.autoAlignAxis(toSuperviewAxis: .horizontal)
        mainTable.isHidden = true
    }
    
    override func showErrorView() {
        errorView.isHidden = false
        mainTable.isHidden = true
    }
    
    override func hideErrorView() {
        errorView.isHidden = true
        mainTable.isHidden = false
    }
    
    override func showLoadingView() {
        preloaderView.isHidden = false
        mainTable.isHidden = true
    }
    
    override func hideLoadingView() {
        preloaderView.isHidden = true
        mainTable.isHidden = false
    }
    
    func getToast(message: String, _ style: ToastStyle) {
        self.showToast(message: message, style, duration: 1)
    }
    
    func reloadTableView() {
        UIView.transition(with: mainTable, duration: 0.0, options: .transitionCrossDissolve, animations: {
            self.mainTable.reloadData()
        }, completion: { _ in
            self.segmentControl.setTitle("\(self.presenter!.getFriendsCount()) \(self.getStringByDeclension(number: self.presenter!.getFriendsCount(), arrayWords: ProfileLocalization.freindsString))", forSegmentAt: 0)
            self.segmentControl.setTitle("\(self.presenter!.getOnlineFriends().count) онлайн", forSegmentAt: 1)
            guard self.refreshControl.isRefreshing else { return }
            self.refreshControl.endRefreshing()
        })
    }
    
    func openPopup(headerText: String, descriptionText: String, confrimText: String?, declineText: String?) {
        self.showPopup(headerText: headerText, descriptionText: descriptionText, confrimText: confrimText, declineText: declineText)
    }
    
    override func confrimAction() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.presenter?.onSwipeUser(indexPath: SavedVariables.indexPath!, isOnlineSegment: false, completion: nil)
        case 1:
            self.presenter?.onSwipeUser(indexPath: SavedVariables.indexPath!, isOnlineSegment: true, completion: nil)
        default:
            return
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refresh(_ sender: Any) {
        presenter?.start(userId: SavedVariables.userIdsFriendsViewController.last ?? "")
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        default:
            reloadTableView()
        }
    }
    
    override func onReachabilityStatusChanged(_ notification: Notification) {
        if let info = notification.userInfo {
            if info[ReachabilityNotificationStatusItem] != nil {
                if (SwiftReachability.sharedManager?.isReachable())! {
                    self.presenter?.start(userId: FriendsViewController.usersIds.last ?? "")
                }
            }
        }
    }
}
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard presenter != nil else { return 1 }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            footerView.text = "\(presenter!.getFriendsCount()) \(getStringByDeclension(number: presenter!.getFriendsCount(), arrayWords: ProfileLocalization.freindsString))"
            return presenter!.getFriendsCount()
        case 1:
            footerView.text = "\(presenter!.getOnlineFriends().count) онлайн"
            return presenter!.getOnlineFriends().count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard presenter != nil else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        switch segmentControl.selectedSegmentIndex {
        case 0:
            cell.setup(model: presenter!.getFriend(indexPath: indexPath))
            return cell
        case 1:
            cell.setup(model: presenter!.getOnlineFriends()[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard presenter != nil else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            presenter?.onTapUser(indexPath: indexPath, isOnlineSegment: false)
        case 1:
            presenter?.onTapUser(indexPath: indexPath, isOnlineSegment: true)
        default:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard FriendsViewController.userId == UserDefaults.standard.string(forKey: "userId") else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard FriendsViewController.userId == UserDefaults.standard.string(forKey: "userId") else { return nil }
        let editAction: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "Сообщение", handler: { (action: UITableViewRowAction ,indexPath: IndexPath ) in
            self.getToast(message: "Отправка сообщений временно недоступна", .warning)
        })
        editAction.backgroundColor = .toasterBlue
        
        let deleteAction: UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "Удалить", handler: { (action: UITableViewRowAction ,indexPath: IndexPath ) in
            SavedVariables.indexPath = indexPath
            switch self.segmentControl.selectedSegmentIndex{
            case 0:
                self.presenter?.getName(nameCase: .acc, indexPath: indexPath, isOnlineSegment: false)
            case 1:
                self.presenter?.getName(nameCase: .acc, indexPath: indexPath, isOnlineSegment: true)
            default:
                return
            }
        })
        deleteAction.backgroundColor = .toasterRed
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
extension FriendsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.searchController.searchBar.setDefaultPlaceHolder()
            self.view.layoutIfNeeded()
            searchBar.layoutIfNeeded()
        })
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.searchController.searchBar.setCenteredPlaceHolder()
            self.view.layoutIfNeeded()
            searchBar.layoutIfNeeded()
        })
    }
}
extension FriendsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
