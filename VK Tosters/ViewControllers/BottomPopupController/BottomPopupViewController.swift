//
//  BottomPopupViewController.swift
//  Trendyol
//
//  Created by Emre on 11.09.2018.
//  Copyright © 2018 Trendyol.com. All rights reserved.
//

import UIKit

open class BottomPopupViewController: UIViewController, BottomPopupAttributesDelegate {
    private var transitionHandler: BottomPopupTransitionHandler?
    open weak var popupDelegate: BottomPopupDelegate?
    
    // MARK: Initializations
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setParameters()
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setParameters()
        initialize()
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        transitionHandler?.notifyViewLoaded(withPopupDelegate: popupDelegate)
        popupDelegate?.bottomPopupViewLoaded()
        self.view.accessibilityIdentifier = popupViewAccessibilityIdentifier
        setupPopup()
        setupButtons()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        curveTopCorners()
        popupDelegate?.bottomPopupWillAppear()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        popupDelegate?.bottomPopupDidAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        popupDelegate?.bottomPopupWillDismiss()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        popupDelegate?.bottomPopupDidDismiss()
    }
    
    //MARK: Private Methods
    
    private func initialize() {
        transitionHandler = BottomPopupTransitionHandler(popupViewController: self)
        transitioningDelegate = transitionHandler
        modalPresentationStyle = .custom
    }
    
    private func curveTopCorners() {
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: popupTopCornerRadius, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
    
    //MARK: BottomPopupAttributesDelegate Variables
    
    open var popupHeight: CGFloat { return BottomPopupConstants.kDefaultHeight }
    
    open var popupTopCornerRadius: CGFloat { return BottomPopupConstants.kDefaultTopCornerRadius }
    
    open var popupPresentDuration: Double { return BottomPopupConstants.kDefaultPresentDuration }
    
    open var popupDismissDuration: Double { return BottomPopupConstants.kDefaultDismissDuration }
    
    open var popupShouldDismissInteractivelty: Bool { return BottomPopupConstants.dismissInteractively }
    
    open var popupDimmingViewAlpha: CGFloat { return BottomPopupConstants.kDimmingViewDefaultAlphaValue }
    
    open var popupShouldBeganDismiss: Bool { return BottomPopupConstants.shouldBeganDismiss }
    
    open var popupViewAccessibilityIdentifier: String { return BottomPopupConstants.defaultPopupViewAccessibilityIdentifier }
    
    open func setupPopup() { }
    
    open func setParameters(duration: Double? = 0, dimmingViewAlpha: CGFloat? = 0, headerText: String? = "", descriptionText: String? = "", confrimText: String? = "", declineText: String? = "") { }
    
    open func setupButtons() { }
    
    @objc open func confrimActionHandler() -> () { }
    
    @objc open func declineActionHandler() -> () { }
}
