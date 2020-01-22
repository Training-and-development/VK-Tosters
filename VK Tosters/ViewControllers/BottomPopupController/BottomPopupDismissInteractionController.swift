//
//  DraggableDismissInteractionController.swift
//  PresentationController
//
//  Created by Emre on 11.09.2018.
//  Copyright © 2018 Emre. All rights reserved.
//

import UIKit

protocol BottomPopupDismissInteractionControllerDelegate: class {
    func dismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat)
}

final class BottomPopupDismissInteractionController: UIPercentDrivenInteractiveTransition {
    private let kMinPercentOfVisiblePartToCompleteAnimation = CGFloat(0.5)
    private let kSwipeDownThreshold = CGFloat(1000)
    private weak var presentedViewController: BottomPresentableViewController?
    private weak var transitioningDelegate: BottomPopupTransitionHandler?
    private unowned var attributesDelegate: BottomPopupAttributesDelegate
    weak var delegate: BottomPopupDismissInteractionControllerDelegate?
    
    override var completionSpeed: CGFloat {
        get {
            return 1
        }
        set {
            return
        }
    }
    
    override var completionCurve: UIView.AnimationCurve {
        get {
            return .easeInOut
        }
        set {
            return
        }
    }
    
    override var duration: CGFloat {
        get {
            return 1
        }
        set {
            return
        }
    }
    
    private var currentPercent: CGFloat = 0 {
        didSet {
            delegate?.dismissInteractionPercentChanged(from: oldValue, to: currentPercent)
        }
    }
    
    init(presentedViewController: BottomPresentableViewController?, attributesDelegate: BottomPopupAttributesDelegate) {
        self.presentedViewController = presentedViewController
        self.transitioningDelegate = presentedViewController?.transitioningDelegate as? BottomPopupTransitionHandler
        self.attributesDelegate = attributesDelegate
        super.init()
        preparePanGesture(in: presentedViewController?.view)
    }
    
    private func finishAnimation(withVelocity velocity: CGPoint) {
        if currentPercent > kMinPercentOfVisiblePartToCompleteAnimation || velocity.y > kSwipeDownThreshold {
            UIView.transition(with: presentedViewController!.view, duration: 1, options: .curveEaseOut, animations: {
                self.finish()
                self.presentedViewController?.view.layoutIfNeeded()
            })
        } else {
            UIView.transition(with: presentedViewController!.view, duration: 1, options: .curveEaseOut, animations: {
                self.cancel()
                self.presentedViewController?.view.layoutIfNeeded()
            })
        }
    }
    
    private func preparePanGesture(in view: UIView?) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        presentedViewController?.view?.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        guard attributesDelegate.popupShouldBeganDismiss else { return }
            
        let translationY = pan.translation(in: presentedViewController?.view).y
        currentPercent = min(max(translationY/(presentedViewController?.view.frame.size.height ?? 0), 0), 1)
        
        switch pan.state {
        case .began:
            transitioningDelegate?.isInteractiveDismissStarted = true
            presentedViewController?.dismiss(animated: true, completion: nil)
        case .changed:
            update(currentPercent)
        case .ended:
            let velocity = pan.velocity(in: presentedViewController?.view)
            transitioningDelegate?.isInteractiveDismissStarted = false
            finishAnimation(withVelocity: velocity)
        default: break
        }
    }
}
