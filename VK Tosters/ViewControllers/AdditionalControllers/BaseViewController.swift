//
//  BaseViewController.swift
//  VK Tosters
//
//  Created by programmist_np on 24/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import SwiftyVK
import PureLayout
import Material

struct ReachabilityState {
    static var global = false
}

open class BaseViewController: UIViewController {
    var toaster = UIToaster()
    var sessionState = VK.sessions.default.state
    var isFirstRun: Bool = true
    var footer: TableFooterView = TableFooterView(frame: CGRect(origin: .zero, size: CGSize(width: Screen.bounds.width, height: 56)))
    let errorView = ErrorView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 24, height: 97)))
    var toolbar: Toolbar = Toolbar(frame: CGRect(origin: .zero, size: CGSize(width: Screen.bounds.width, height: .zero)))
    let toasterContainer: UIView = {
        let view = UIView()
        view.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 36))
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()
    let errorContainer: UIView = {
        let container = UIView()
        return container
    }()
    let loadingContainer: UIView = {
        let container = UIView()
        let loadingView = LoadingView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width - 24, height: 97)))
        container.addSubview(loadingView)
        loadingView.autoCenterInSuperview()
        return container
    }()
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .toasterDarkGray
        view.autoSetDimensions(to: CGSize(width: UIScreen.main.bounds.width, height: 0.5))
        return view
    }()
    let mainTable = TableView(frame: .zero, style: .plain)
    lazy var refreshControl = UIRefreshControl()

    override open func viewDidLoad() {
        self.view.backgroundColor = .toasterWhite
        setupObservers()
        prepareToolbar()
        prepareTable()
        prepareFooter()
        setupError()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        isFirstRun = true
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isFirstRun = false
    }
    
    func prepareToolbar() {
        self.view.addSubview(toolbar)
        toolbar.autoAlignAxis(toSuperviewAxis: .vertical)
        toolbar.autoPinEdge(toSuperviewSafeArea: .top)
        toolbar.autoSetDimension(.height, toSize: 52)
        toolbar.backgroundColor = .toasterWhite
        toolbar.titleLabel.textColor = .toasterBlack
        toolbar.titleLabel.font = UIFont(name: "Roboto-Medium", size: 18)
        toolbar.detailLabel.textColor = .toasterDarkGray
        toolbar.detailLabel.font = UIFont(name: "Roboto-Medium", size: 15)
        toolbar.shadowColor = .toasterBlack
        toolbar.addSubview(dividerView)
        dividerView.autoPinEdge(toSuperviewEdge: .bottom)
        dividerView.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    func prepareTable() {
        self.view.addSubview(mainTable)
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        mainTable.addSubview(refreshControl)
        mainTable.separatorStyle = .none
        mainTable.autoPinEdge(.top, to: .bottom, of: toolbar, withOffset: 0)
        mainTable.autoPinEdge(.trailing, to: .trailing, of: self.view, withOffset: 0)
        mainTable.autoPinEdge(.leading, to: .leading, of: self.view, withOffset: 0)
        mainTable.autoPinEdge(.bottom, to: .bottom, of: self.view, withOffset: 0)
        mainTable.backgroundColor = .toasterWhite
        self.view.addSubview(toasterContainer)
        toasterContainer.autoPinEdge(.top, to: .bottom, of: toolbar, withOffset: 0)
    }
    
    func prepareFooter() {
        footer.backgroundColor = .toasterWhite
        mainTable.tableFooterView = footer
        mainTable.tableFooterView?.backgroundColor = .toasterWhite
        mainTable.tableFooterView?.bounds.size.height = 56
    }
    
    open func updateToolbar() { }
    
    open func configureTableView() { }
    
    open func updateFooter(text: String, _ state: Int) { }
    
    open func setup() { }
    
    @objc open func refresh(_ sender: Any) { }

    func showToast(message: String, _ style: ToastStyle, duration: TimeInterval = 1) {
        self.toaster.hide(view: self.toasterContainer, toast: self.toaster.toast, isNeedAnimation: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.toaster.hide(view: self.toasterContainer, toast: self.toaster.toast, isNeedAnimation: false)
            self.toaster.show(view: self.toasterContainer, style: style, message: message, duration: duration)
        })
    }
    
    open var isLogged: Bool {
        guard currentSessionState == .authorized else { return false }
        return true
    }
    
    open var currentSessionState: SessionState {
        switch sessionState {
        case .destroyed:
            return .destroyed
        case .authorized:
            return .authorized
        case .initiated:
            return .initiated
        }
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override open func viewWillLayoutSubviews() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    open func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin(_:)), name: .onLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onLogout(_:)), name: .onLogout, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onReachabilityStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(controlNetwork(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotification), object: nil)
    }
    
    open func setOnlinePlatform(platform: Int) -> String {
        switch platform {
        case 1: return "(мобильная версия)"
        case 2: return "(iPhone)"
        case 3: return "(iPad)"
        case 4: return "(Android)"
        case 5: return "(Windows Phone)"
        case 6: return "(Windows 10)"
        case 7: return "(полная версия)"
        default: return ""
        }
    }
    
    open func confrimAction() { }
    
    open func declineAction() { }
    
    open func setupError() {
        self.view.addSubview(errorContainer)
        errorContainer.autoPinEdgesToSuperviewEdges()
        errorContainer.isHidden = true
        errorContainer.addSubview(errorView)
        errorView.autoCenterInSuperview()
    }
    
    open func showErrorView(errorText: String) {
        errorView.setup(errorText: errorText)
        toolbar.title = "Ошибка загрузки"
        errorContainer.isHidden = false
        mainTable.isHidden = true
        loadingContainer.isHidden = true
    }
    
    open func hideErrorView() {
        errorContainer.isHidden = true
        mainTable.isHidden = false
    }
    
    open func showLoadingView() {
        toolbar.title = "Загрузка"
        loadingContainer.isHidden = false
        mainTable.isHidden = true
    }
    
    open func hideLoadingView() {
        loadingContainer.isHidden = true
        mainTable.isHidden = false
    }
    
    @objc func onLogin(_ notification: Notification) {
        sessionState = SessionState.authorized
        NotificationCenter.default.post(name: .onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.showToast(message: "Вы авторизованы", .success, duration: 1)
        })
    }
    
    @objc func onLogout(_ notification: Notification) {
        sessionState = SessionState.initiated
        NotificationCenter.default.post(name: .onChangeSessionState, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.showToast(message: "Вы вышли из аккаунта", .warning, duration: 1)
        })
    }
    
    @objc func onReachabilityStatusChanged(_ notification: Notification) { }
    
    @objc private func controlNetwork(_ notification: Notification) {
        if let info = notification.userInfo {
            if info[ReachabilityNotificationStatusItem] != nil {
                if (SwiftReachability.sharedManager?.isReachable())! {
                    guard !isFirstRun else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.showToast(message: CommonLocalization.connected, .default, duration: 1)
                    })
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                        self.showToast(message: CommonLocalization.notConnected, .error, duration: -1)
                    })
                }
            }
        }
    }
}
