//
//  LogoutPopup.swift
//  VK Tosters
//
//  Created by programmist_np on 20/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit

class PopupViewController: BottomPopupViewController {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var confrimButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dismissControl: UIButton!
    @IBOutlet weak var blurScreen: UIView!
    @IBOutlet weak var tongue: UIView!
    
    var duration: Double?
    var dimmingViewAlpha: CGFloat?
    
    var headerText: String?
    var descriptionText: String?
    var confrimText: String?
    var declineText: String?
    
    var rootController: BaseViewController?
            
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setParameters(duration: Double?, dimmingViewAlpha: CGFloat?, headerText: String?, descriptionText: String?, confrimText: String?, declineText: String?) {
        super.setParameters(duration: duration, dimmingViewAlpha: dimmingViewAlpha, headerText: headerText, descriptionText: descriptionText, confrimText: confrimText, declineText: declineText)
        self.duration = duration
        self.dimmingViewAlpha = dimmingViewAlpha
        self.headerText = headerText
        self.descriptionText = descriptionText
        self.confrimText = confrimText
        self.declineText = declineText
    }
    
    // Настройка кнопок попапа
    override func setupButtons() {
        super.setupButtons()
        self.declineButton.isUserInteractionEnabled = true
        self.confrimButton.isUserInteractionEnabled = true
        
        let gestureConfrim: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(declineActionHandler))
        let gestureDecline: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(confrimActionHandler))
        
        gestureConfrim.numberOfTapsRequired = 1
        gestureDecline.numberOfTapsRequired = 1
        
        self.declineButton.addGestureRecognizer(gestureConfrim)
        self.confrimButton.addGestureRecognizer(gestureDecline)
    }
    
    // Настройка самого попапа
    override func setupPopup() {
        super.setupPopup()
        self.view.bounds.size.height = rootView.bounds.size.height
        print(self.view.bounds.size.height, rootView.bounds.size.height)

        tongue.blurry()
        tongue.backgroundColor = .clear
        tongue.setRounded()
        
        blurScreen.blurry()
        blurScreen.backgroundColor = .clear
        
        rootView.setCorners(radius: 16.0)
        rootView.backgroundColor = Colors.shared.white.withAlphaComponent(0.5)
        
        headerLabel.text = headerText ?? ""
        headerLabel.textColor = Colors.shared.black
        headerLabel.font = UIFont(name: "Lato-Bold", size: 20)
        
        descriptionLabel.font = UIFont(name: "Lato-Regular", size: 15)
        descriptionLabel.text = descriptionText ?? ""
        descriptionLabel.textColor = Colors.shared.black
        
        declineButton.setCorners(radius: 5.0)
        declineButton.setTitle(declineText, for: .normal)
        declineButton.autoresizingMask = [.flexibleWidth]
        declineButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        declineButton.backgroundColor = Colors.shared.red
        declineButton.setTitleColor(Colors.shared.white, for: .normal)
        
        confrimButton.setCorners(radius: 5.0)
        confrimButton.setTitle(confrimText, for: .normal)
        confrimButton.autoresizingMask = [.flexibleWidth]
        confrimButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        confrimButton.backgroundColor = Colors.shared.blue
        confrimButton.setTitleColor(Colors.shared.white, for: .normal)
    
        dismissControl.setImage(dismissControl.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        dismissControl.imageView?.tintColor = Colors.shared.metal
    }
    
    @objc override func confrimActionHandler() -> () {
        super.confrimActionHandler()
        dismiss(animated: true, completion: { [weak self] in
            guard let strongSelf = self else { return }
            let controller = strongSelf.rootController
            controller?.confrimAction()
        })
    }
    
    @objc override func declineActionHandler() -> () {
        super.declineActionHandler()
        dismiss(animated: true, completion: { [weak self] in
            guard let strongSelf = self else { return }
            let controller = strongSelf.rootController
            controller?.declineAction()
        })
    }
    
    override var popupHeight: CGFloat {
        return getSharedHeight()
    }
    
    override var popupTopCornerRadius: CGFloat {
        return CGFloat(12)
    }
    
    override var popupPresentDuration: Double {
        return duration ?? 1.0
    }
    
    override var popupDismissDuration: Double {
        return duration ?? 1.0
    }
    
    override var popupShouldDismissInteractivelty: Bool {
        return true
    }
    
    override var popupDimmingViewAlpha: CGFloat {
        return dimmingViewAlpha ?? BottomPopupConstants.kDimmingViewDefaultAlphaValue
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension PopupViewController {
    // Вернуть общий размер
    private func getSharedHeight() -> CGFloat {
        let textHeight: CGFloat = (self.headerLabel.text?.boundingRect(with: self.headerLabel.frame.size, options: .usesLineFragmentOrigin, attributes:[NSAttributedString.Key.font: self.headerLabel.font!], context: nil).size.width)!
        return textHeight
    }
}
