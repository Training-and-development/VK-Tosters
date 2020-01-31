//
//  MessageViewCell.swift
//  VK Tosters
//
//  Created by programmist_np on 30/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyVK
import SwiftyJSON

class MessageViewCell: UITableViewCell {
    @IBOutlet weak var avatarInterlocutor: UIImageView!
    @IBOutlet weak var avatarSender: UIImageView!
    @IBOutlet weak var nameInterlocutor: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var lastMessageViw: UIView!
    @IBOutlet weak var avatarWidth: NSLayoutConstraint!
    @IBOutlet weak var avatarPadding: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(conversation: Conversation, lastMessage: LastMessage, user: User, me: User) {
        setupLastMessage(conversation, lastMessage)
        setupInterlocutor(user, conversation)
        setupSender(me)
        setupLayer()
    }
    
    func setupLayer() {
        DispatchQueue.main.async {
            self.avatarInterlocutor.setRounded()
            self.avatarSender.setRounded()
            self.lastMessageViw.setRounded()
            self.nameInterlocutor.textColor = .toasterBlack
            self.nameInterlocutor.font = UIFont(name: "Lato-Bold", size: 18)
            self.messageText.textColor = .toasterMetal
            self.messageText.font = UIFont(name: "Lato-Regular", size: 16)
        }
    }
    
    func setupLastMessage(_ conversation: Conversation, _ lastMessage: LastMessage) {
        if conversation.inRead != lastMessage.id {
            lastMessageViw.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.3)
        } else {
            lastMessageViw.backgroundColor = UIColor.toasterWhite.withAlphaComponent(0.3)
        }
        messageText.text = lastMessage.text
        if "\(lastMessage.fromId)" != UserDefaults.standard.string(forKey: "userId") {
            avatarWidth.constant = 0
            avatarPadding.constant = 0
            avatarSender.isHidden = true
            setNeedsUpdateConstraints()
        } else {
            avatarWidth.constant = 25
            avatarPadding.constant = 8
            avatarSender.isHidden = false
            setNeedsUpdateConstraints()
        }
    }
    
    func setupInterlocutor(_ user: User, _ conversation: Conversation) {
        avatarInterlocutor.kf.setImage(with: URL(string: user.photo100))
        nameInterlocutor.text = user.name
    }
    
    func setupSender(_ user: User) {
        avatarSender.kf.setImage(with: URL(string: user.photo100))
    }
}
