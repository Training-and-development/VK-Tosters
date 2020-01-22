//
//  FriendCell.swift
//  VK Tosters
//
//  Created by programmist_np on 21/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    let nameLabel: UILabel = {
        let name = UILabel()
        return name
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupConstrints() {
        self.contentView.addSubview(nameLabel)
        nameLabel.text = " disgs "
        nameLabel.textColor = .green
    }
}
