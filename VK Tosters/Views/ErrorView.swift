//
//  ErrorView.swift
//  VK Tosters
//
//  Created by programmist_np on 24/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import PureLayout

class ErrorView: UIView {
    var isConstraintInstall: Bool = false
    let errorView: UIView = {
        let view = UIView()
        return view
    }()
    
    let errorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "error")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = Colors.shared.metal
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = Colors.shared.metal
        label.textAlignment = .center
        return label
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
        self.addSubview(errorView)
        errorView.addSubview(errorLabel)
        errorView.addSubview(errorImage)
    }
    
    override func updateConstraints() {
        if !isConstraintInstall {
            isConstraintInstall = true
            
            errorView.autoPinEdgesToSuperviewEdges()
            
            errorImage.autoAlignAxis(toSuperviewAxis: .vertical)
            errorImage.autoPinEdge(.top, to: .top, of: errorView, withOffset: 12)
            errorImage.autoPinEdge(.bottom, to: .top, of: errorLabel, withOffset: -16)
            
            errorLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            errorLabel.autoPinEdge(.bottom, to: .bottom, of: errorView, withOffset: 0)
        }
        super.updateConstraints()
    }
    
    func setup() {
        errorLabel.text = "Произошла ошибка подключения"
    }
}
