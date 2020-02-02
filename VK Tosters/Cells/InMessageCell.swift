//
//  InMessageCell.swift
//  VK Tosters
//
//  Created by programmist_np on 01/02/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import PureLayout
import Kingfisher

class InMessageCell: UITableViewCell {
    @IBOutlet weak var avatarSender: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(dialogMessageModel: DialogMessageModel, me: User) {
        avatarSender.kf.setImage(with: URL(string: me.photo100))
        messageLabel.text = dialogMessageModel.attachments.type == "" ? dialogMessageModel.text : dialogMessageModel.attachments.type
        let timeInterval = Double(dialogMessageModel.date)
        let date = Date(timeIntervalSince1970: timeInterval)
        timeLabel.text = CommonLocalization.getTime(time: date)
        setupUI()
    }
    
    func setupUI() {
        avatarSender.setRounded()
        messageLabel.textColor = .toasterBlack
        messageLabel.font = UIFont(name: "Lato-Semibold", size: 15)
        messageView.setCorners(radius: 16)
        messageView.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.2)
        messageView.setupBorder(width: 0.5, color: .toasterBlue)
        timeLabel.font = UIFont(name: "Lato-Semibold", size: 12)
        timeLabel.textColor = .toasterMetal
    }
}
