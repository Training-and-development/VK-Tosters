//
//  AndroidNavigationBar.swift
//  VK Tosters
//
//  Created by programmist_np on 27/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import FLAnimatedImage

class AndroidNavigationBar: UIView {
    var isConstraintInstall: Bool = false
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .toasterSmoke
        return view
    }()
    
    var backImageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .toasterBlue
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .toasterBlack
        label.textAlignment = .left
        return label
    }()
    
    let moreButton: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "logout")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .toasterBlue
        return button
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
        self.addSubview(contentView)
        contentView.addSubview(backImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)
    }
    
    override func updateConstraints() {
        if !isConstraintInstall {
            isConstraintInstall = true
            
            contentView.autoPinEdgesToSuperviewEdges()
            
            backImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
            backImageView.autoSetDimension(.height, toSize: 24)
            backImageView.autoSetDimension(.width, toSize: 24)
            backImageView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16)
            
            titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
            titleLabel.autoPinEdge(.leading, to: .trailing, of: backImageView, withOffset: 16)
            titleLabel.autoPinEdge(.trailing, to: .leading, of: moreButton, withOffset: 16)
            
            moreButton.autoAlignAxis(toSuperviewAxis: .horizontal)
            moreButton.autoSetDimension(.height, toSize: 24)
            moreButton.autoSetDimension(.width, toSize: 24)
            moreButton.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        }
        super.updateConstraints()
    }
    
    func setupNavigationBar(title: String, isNeedBackButton: Bool, isNeedMoreButton: Bool) {
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Lato-Bold", size: 22)
        backImageView.isHidden = isNeedBackButton ? false : true
        moreButton.isHidden = isNeedMoreButton ? false : true
    }
}

