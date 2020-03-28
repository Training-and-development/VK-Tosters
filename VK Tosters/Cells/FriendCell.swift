//
//  FriendCell.swift
//  VK Tosters
//
//  Created by programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import Kingfisher

class FriendCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var onlineImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(model: Friend) {
        setupCellComponent()
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setActiveUser(model: model)
            guard model.deactivated != "" else { return }
            strongSelf.setDeactiveUser(deactivated: model.deactivated!)
        }
    }
    
    func setActiveUser(model: Friend) {
        nameView.text = model.name
        if model.online == 0 {
            descriptionView.text = VKLocalization.getLastSeen(sex: model.sex, time: model.lastSeen.parseTime)
            onlineView.isHidden = true
        } else if model.online == 1 {
            descriptionView.text = "Онлайн"
            onlineView.isHidden = false
        }
        onlineImage.image = setOnlinePlatform(platform: model.lastSeen.platform)
        onlineImage.tintColor = .toasterGreen
        avatarView.kf.setImage(with: URL(string: model.photo100))
    }
    
    func setOnlinePlatform(platform: Int) -> UIImage {
        switch platform {
        case 1: return UIImage(named: "mobile-online")!.withRenderingMode(.alwaysTemplate)
        case 2, 3: return UIImage(named: "apple-online")!.withRenderingMode(.alwaysTemplate)
        case 4: return UIImage(named: "android-online")!.withRenderingMode(.alwaysTemplate)
        case 5, 6: return UIImage(named: "windows-online")!.withRenderingMode(.alwaysTemplate)
        case 7: return UIImage(named: "online-pc")!.withRenderingMode(.alwaysTemplate)
        default: return UIImage()
        }
    }
    
    func setDeactiveUser(deactivated: String) {
        descriptionView.text = VKLocalization.getDeactivateState(deactivate: deactivated, hasShort: false)
    }
    
    func setupCellComponent() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.avatarView.setRounded()
            strongSelf.nameView.font = UIFont(name: "Lato-Bold", size: 18)
            strongSelf.nameView.textColor = .toasterBlack
            strongSelf.descriptionView.font = UIFont(name: "Lato-Regular", size: 15)
            strongSelf.descriptionView.textColor = .toasterMetal
            strongSelf.onlineView.setRounded()
        }
    }
}
