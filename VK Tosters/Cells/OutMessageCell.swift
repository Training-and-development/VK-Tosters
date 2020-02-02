//
//  OutMessageCell.swift
//  VK Tosters
//
//  Created by programmist_np on 01/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import Kingfisher

class OutMessageCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(dialogMessageModel: DialogMessageModel, user: User) {
        avatarView.kf.setImage(with: URL(string: user.photo100))
        messageLabel.text = dialogMessageModel.attachments.type == "" ? dialogMessageModel.text : dialogMessageModel.attachments.type
        let timeInterval = Double(dialogMessageModel.date)
        let date = Date(timeIntervalSince1970: timeInterval)
        timeLabel.text = CommonLocalization.getTime(time: date)
        setupUI()
    }
    
    func setupUI() {
        avatarView.setRounded()
        messageLabel.textColor = .toasterBlack
        messageLabel.font = UIFont(name: "Lato-Semibold", size: 15)
        messageView.setCorners(radius: 16)
        messageView.backgroundColor = UIColor.toasterSmoke
        messageView.setupBorder(width: 0.5, color: .toasterMetal)
        timeLabel.font = UIFont(name: "Lato-Semibold", size: 12)
        timeLabel.textColor = .toasterMetal
    }
}
