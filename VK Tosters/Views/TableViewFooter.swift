//
//  TableViewFooter.swift
//  Epic Phrases
//
//  Created by programmist_np on 18.03.2020.
//  Copyright © 2020 Funny Applications. All rights reserved.
//

import Foundation
import UIKit
import Material

class TableFooterView: UIView {
    var isConstraintInstall: Bool = false
    
    let textView: UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: Screen.bounds.width, height: 56)))
        label.font = RobotoFont.regular(with: 14)
        label.textColor = .toasterGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let progressView: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: Screen.bounds.width, height: 56)))
        progress.hidesWhenStopped = true
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addSubview(textView)
        self.addSubview(progressView)
    }
    
    override func updateConstraints() {
        if !isConstraintInstall {
            isConstraintInstall = true
            self.frame = CGRect(origin: .zero, size: CGSize(width: Screen.bounds.width, height: 56))
            textView.autoPinEdgesToSuperviewEdges()
            progressView.autoCenterInSuperview()
        }
        super.updateConstraints()
    }
    
    func setStateViews(_ state: Int) {
        switch state {
        case 0:
            textView.isHidden = true
            progressView.isHidden = false
            progressView.startAnimating()
        case 1:
            textView.isHidden = false
            progressView.isHidden = true
            progressView.stopAnimating()
        case 2:
            textView.isHidden = true
            progressView.isHidden = true
            progressView.stopAnimating()
        default:
            break
        }
    }
    
    func setup(text: String, _ state: Int) {
        setStateViews(state)
        textView.text = text
    }
}
