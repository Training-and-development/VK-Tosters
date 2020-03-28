//
//  TextInputContainer.swift
//  Epic Phrases
//
//  Created by programmist_np on 15.03.2020.
//  Copyright © 2020 Funny Applications. All rights reserved.
//

import Foundation
import Material
import Kingfisher
import UIKit

class TextInputContainer: UIView {
    var isConstraintInstall: Bool = false
    var isKeyboardShow: Bool = false
    var isFullFieldOpen: Bool = false
    var keyboardHeight: CGFloat = 0
    let fakeTextView: UIView = {
        let fake = UIView()
        return fake
    }()
    let addButton: IconButton = {
        let button = IconButton(image: Icon.cm.add, tintColor: .toasterBlue)
        return button
    }()
    let textView: TextView = {
        let textView = TextView()
        textView.placeholderLabel.text = "Ваш коммент"
        textView.placeholderLabel.textColor = UIColor.toasterBlack.withAlphaComponent(0.5)
        textView.textColor = .toasterBlack
        return textView
    }()
    let sendButton: IconButton = {
        let button = IconButton(image: Icon.cm.arrowBack, tintColor: .white)
        button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        return button
    }()
    var selfHeight: NSLayoutConstraint?
    var textContainerHeight: NSLayoutConstraint?

    override func layoutSubviews() {
        super.layoutSubviews()
        fakeTextView.setBorder(18, width: 0.5, color: .toasterDarkGray)
        sendButton.setBorder(sendButton.roundedSize, width: 0)
        addButton.setBorder(sendButton.roundedSize, width: 0.5, color: .toasterDarkGray)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addSubview(addButton)
        self.addSubview(sendButton)
        self.addSubview(fakeTextView)
        fakeTextView.addSubview(textView)
        textView.delegate = self
        textView.bounces = false
    }
    
    override func updateConstraints() {
        if !isConstraintInstall {
            isConstraintInstall = true
            self.translatesAutoresizingMaskIntoConstraints = true
            textView.autoPinEdge(.top, to: .top, of: fakeTextView, withOffset: 6.5)
            textView.autoPinEdge(.bottom, to: .bottom, of: fakeTextView, withOffset: 6)
            textView.autoPinEdge(.leading, to: .leading, of: fakeTextView, withOffset: 4)
            textView.autoPinEdge(.trailing, to: .trailing, of: fakeTextView, withOffset: 4)
            selfHeight = self.autoSetDimension(.height, toSize: 52)
            addButton.autoPinEdge(.leading, to: .leading, of: self, withOffset: 8)
            addButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -8)
            addButton.autoSetDimensions(to: CGSize(width: 36, height: 36))
            sendButton.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -8)
            sendButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -8)
            sendButton.autoSetDimensions(to: CGSize(width: 36, height: 36))
            fakeTextView.autoPinEdge(.leading, to: .trailing, of: addButton, withOffset: 8)
            fakeTextView.autoPinEdge(.trailing, to: .leading, of: sendButton, withOffset: -8)
            fakeTextView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -8)
            fakeTextView.autoPinEdge(.top, to: .top, of: self, withOffset: 8)
            textContainerHeight = textView.autoSetDimension(.height, toSize: 36)
        }
        super.updateConstraints()
    }
    
    func setup() {
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor = .toasterWhite
        fakeTextView.setBorder(18, width: 1, color: .toasterDarkGray)
        textView.textContainerInsets = UIEdgeInsets(top: 0, left: 4, bottom: 14, right: 0)
        sendButton.backgroundColor = .toasterBlue
        sendButton.setBorder(sendButton.roundedSize, width: 0)
        addButton.setBorder(sendButton.roundedSize, width: 0.5, color: .toasterDarkGray)
        sendButton.isEnabled = false
        sendButton.alpha = 0.4
    }
    
    func setTextViewHeight(_ textRequiredHeight: CGFloat) {
        switch textView.requiredHeightFromUITextView {
        case 21.333333333333332:
            selfHeight?.constant = 52
        case 42.333333333333336:
            selfHeight?.constant = 72
        case 63.333333333333336:
            selfHeight?.constant = 92
        case 84.66666666666667:
            selfHeight?.constant = 112
        case 105.66666666666667:
            selfHeight?.constant = 132
        default:
            break
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.fakeTextView.layoutIfNeeded()
        })
    }
}
extension TextInputContainer: TextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" {
            UIView.animate(withDuration: 0.2, animations: {
                self.sendButton.alpha = 1
                self.layoutIfNeeded()
            }, completion: { _ in
                self.sendButton.isEnabled = true
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.sendButton.alpha = 0.4
                self.layoutIfNeeded()
            }, completion: { _ in
                self.sendButton.isEnabled = false
            })
        }
        setTextViewHeight(textView.requiredHeightFromUITextView)
        self.invalidateIntrinsicContentSize()
    }
}
