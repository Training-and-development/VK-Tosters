//
//  PlaceholderCell.swift
//  VK Tosters
//
//  Created by programmist_np on 22/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit

class PlaceholderCell: UITableViewCell {
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var avatarPlacceholder: UIView!
    @IBOutlet weak var namePlacceholder: UIView!
    @IBOutlet weak var descriptionPlacceholder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        setupComponents()
    }
    
    func setupComponents() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.avatarPlacceholder.setRounded()
            strongSelf.namePlacceholder.setRounded()
            strongSelf.descriptionPlacceholder.setRounded()
            strongSelf.avatarPlacceholder.backgroundColor = Colors.shared.lightGray
            strongSelf.namePlacceholder.backgroundColor = Colors.shared.lightGray
            strongSelf.descriptionPlacceholder.backgroundColor = Colors.shared.lightGray
        }
    }
}
