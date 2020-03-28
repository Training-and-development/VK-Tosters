//
//  MenuCell.swift
//  VK Tosters
//
//  Created by programmist_np on 28.03.2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import Material

class MenuCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(title: String, icon: UIImage?) {
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        menuTitleLabel.text = title
        setupUI()
    }
    
    func setupUI() {
        DispatchQueue.main.async {
            self.menuTitleLabel.font = RobotoFont.regular(with: 15)
            self.menuTitleLabel.textColor = .toasterBlack
            self.iconImageView.tintColor = UIColor(named: "Azure Blue")
        }
    }
}
