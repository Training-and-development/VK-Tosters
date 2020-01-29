//
//  PhotoViewCell.swift
//  VK Tosters
//
//  Created by programmist_np on 28/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: Photo) {
        photoView.setCorners(radius: 8)
        photoimageView.kf.setImage(with: URL(string: model.sizes.url))
    }
}
