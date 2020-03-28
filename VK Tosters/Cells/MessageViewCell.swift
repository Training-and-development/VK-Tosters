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
    @IBOutlet weak var nameInterlocutor: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var lastMessageViw: UIView!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var unreadCountView: UIView!
    @IBOutlet weak var unreadLabel: UILabel!
    @IBOutlet weak var online: UIView!
    @IBOutlet weak var messageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func alternativeSetup(conversation: DBConversation, lastMessage: DBLastMessage) {
        setupUnreadMessage(conversation)
        setupLastMessage(lastMessage)
        setupLayer()
    }
    
    // Настройка графики
    func setupLayer() {
        DispatchQueue.main.async {
            self.avatarInterlocutor.setRounded()
            self.lastMessageViw.setRounded()
            self.onlineView.setRounded()
            self.unreadCountView.setRounded()
            self.online.setRounded()
            self.online.backgroundColor = .toasterWhite
            self.onlineView.backgroundColor = .toasterGreen
            self.unreadCountView.backgroundColor = .toasterRed
            self.unreadLabel.textColor = .toasterWhite
            self.unreadLabel.font = UIFont(name: "Lato-Bold", size: 12)
            self.nameInterlocutor.textColor = .toasterBlack
            self.nameInterlocutor.font = UIFont(name: "Lato-Bold", size: 18)
            self.messageText.font = UIFont(name: "Lato-Regular", size: 16)
            self.nameInterlocutor.textColor = .toasterBlack
            self.messageTimeLabel.font = UIFont(name: "Lato-Regular", size: 14)
            self.messageTimeLabel.textColor = .toasterMetal
        } 
    }
    
    // Установка последнего сообщения
    func setupLastMessage(_ lastMessage: DBLastMessage) {
        messageText.text = lastMessage.text != "" ? lastMessage.text : "Пустое сообщение"
        messageTimeLabel.text = lastMessage.date
    }
    
    // Установка непрочитанного сообщения
    func setupUnreadMessage(_ conversation: DBConversation) {
        // Установка непрочитанного исходящего
        if conversation.inRead != conversation.lastMessageId {
            contentView.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.15)
        } else {
            contentView.backgroundColor = UIColor.clear
        }
        // Установка непрочитанного входящего
        if conversation.outRead != conversation.lastMessageId {
            lastMessageViw.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.15)
        } else {
            lastMessageViw.backgroundColor = UIColor.clear
        }
        // Установка счетчика
        if conversation.unreadCount > 0 {
            unreadCountView.isHidden = false
            unreadLabel.text = "\(conversation.unreadCount)"
        } else {
            unreadCountView.isHidden = true
        }
    }
    
    func setupUserInterlocutor(profile: DBUser) {
        avatarInterlocutor.kf.setImage(with: URL(string: profile.photo100))
        nameInterlocutor.text = "\(profile.firstName) \(profile.lastName)"
        if profile.online == 1 {
            online.isHidden = false
        } else {
            online.isHidden = true
        }
    }
    
    func setupGroupInterlocutor(group: DBGroup) {
        avatarInterlocutor.kf.setImage(with: URL(string: group.photo100))
        nameInterlocutor.text = group.name
    }
}
