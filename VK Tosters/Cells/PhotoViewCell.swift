//
//  PhotoViewCell.swift
//  VK Tosters
//
//  Created by programmist_np on 28/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import Kingfisher
import PureLayout

class PhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: Photo, view: UIView) {
        photoView.autoSetDimension(.height, toSize: (view.frame.size.width - 32) / 3 - 4)
        photoView.autoSetDimension(.width, toSize: (view.frame.size.width - 32) / 3 - 4)
        
        photoView.setCorners(radius: 5)
        photoimageView.kf.setImage(with: URL(string: model.sizes.url))
    }
}
