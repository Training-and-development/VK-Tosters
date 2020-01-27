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
            descriptionView.text = FriendsLocalization.getLastSeen(sex: model.sex, time: model.parseTime)
            onlineView.isHidden = true
        } else if model.online == 1 {
            descriptionView.text = "Онлайн"
            onlineView.isHidden = false
        }
        avatarView.kf.setImage(with: URL(string: model.photo100))
    }
    
    func setDeactiveUser(deactivated: String) {
        descriptionView.text = FriendsLocalization.getDeactivateState(deactivate: deactivated)
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
            strongSelf.onlineImage.backgroundColor = .toasterGreen
            strongSelf.onlineImage.setRounded()
        }
    }
}
