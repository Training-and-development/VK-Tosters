//
//  LoadingView.swift
//  VK Tosters
//
//  Created by programmist_np on 25/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import FLAnimatedImage

class LoadingView: UIView {
    var isConstraintInstall: Bool = false
    let loadingView: UIView = {
        let view = UIView()
        return view
    }()
    
    var loadingImage: UIImageView = {
        var image = UIImageView()
        let gifsName: [String] = ["golovakrug", "osmotr", "prigi"]
        let randomGif = Int(arc4random() % UInt32(gifsName.count))
        let gif = UIImage.gifImageWithName(gifsName[randomGif])
        image = UIImageView(image: gif)
        return image
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка"
        label.font = UIFont(name: "Lato-Bold", size: 12)
        label.textColor = .toasterMetal
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
        self.addSubview(loadingView)
        loadingView.addSubview(loadingLabel)
        loadingView.addSubview(loadingImage)
    }
    
    override func updateConstraints() {
        if !isConstraintInstall {
            isConstraintInstall = true
            
            loadingView.autoPinEdgesToSuperviewEdges()
            
            loadingImage.autoAlignAxis(toSuperviewAxis: .vertical)
            loadingImage.autoSetDimension(.height, toSize: 36)
            loadingImage.autoSetDimension(.width, toSize: 36)
            loadingImage.autoPinEdge(.top, to: .top, of: loadingView, withOffset: 0)
            loadingImage.autoPinEdge(.bottom, to: .top, of: loadingLabel, withOffset: -6)
            
            loadingLabel.autoAlignAxis(toSuperviewAxis: .vertical)
            loadingLabel.autoPinEdge(.bottom, to: .bottom, of: loadingView, withOffset: 0)
        }
        super.updateConstraints()
    }
}
