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
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var unreadCountView: UIView!
    @IBOutlet weak var unreadLabel: UILabel!
    @IBOutlet weak var online: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Общая настройка
    func setup(conversation: Conversation, lastMessage: LastMessage, user: User, me: User) {
        setupLastMessage(conversation, lastMessage)
        setupInterlocutor(user, conversation)
        setupSender(me, lastMessage)
        setupLayer()
    }
    
    // Настройка графики
    func setupLayer() {
        DispatchQueue.main.async {
            self.avatarInterlocutor.setRounded()
            self.avatarSender.setRounded()
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
        } 
    }
    
    // Установка последнего сообщения
    func setupLastMessage(_ conversation: Conversation, _ lastMessage: LastMessage) {
        setupUnreadMessage(conversation, lastMessage)
        messageText.text = lastMessage.attachments.type == "" ? lastMessage.text : lastMessage.attachments.type
        messageText.textColor = lastMessage.attachments.type == "" ? .toasterMetal : .toasterBlue
        unreadLabel.text = "\(conversation.unreadCount)"
    }
    
    // Установка непрочитанного сообщения
    func setupUnreadMessage(_ conversation: Conversation, _ lastMessage: LastMessage) {
        // Установка непрочитанного исходящего
        if conversation.inRead != lastMessage.id {
            contentView.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.15)
        } else {
            contentView.backgroundColor = UIColor.clear
        }
        // Установка непрочитанного входящего
        if conversation.outRead != lastMessage.id {
            lastMessageViw.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.15)
        } else {
            lastMessageViw.backgroundColor = UIColor.clear
        }
        // Установка счетчика
        if conversation.unreadCount > 0 {
            unreadCountView.showViewWithAnimation()
        } else {
            unreadCountView.hideViewWithAnimation()
        }
    }
    
    // Установка собеседника и его данных
    func setupInterlocutor(_ user: User, _ conversation: Conversation) {
        avatarInterlocutor.kf.setImage(with: URL(string: user.photo100))
        nameInterlocutor.text = user.name
        if user.online == 1 {
            online.showViewWithAnimation()
        } else {
            online.hideViewWithAnimation()
        }
    }
    
    // Установка отправителя и его данных
    func setupSender(_ user: User, _ lastMessage: LastMessage) {
        avatarSender.kf.setImage(with: URL(string: user.photo100))
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
}
