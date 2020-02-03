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
    @IBOutlet weak var messageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func alternativeSetup(conversation: ConversationCore) {
        setupLastMessage(conversation)
        setupInterlocutor(conversation)
        setupSender(conversation)
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
            self.nameInterlocutor.textColor = .toasterBlack
            self.messageTimeLabel.font = UIFont(name: "Lato-Regular", size: 14)
            self.messageTimeLabel.textColor = .toasterMetal
        } 
    }
    
    // Установка последнего сообщения
    func setupLastMessage(_ conversation: ConversationCore) {
        setupUnreadMessage(conversation)
        messageText.text = conversation.attachments.type == "" ? conversation.text : conversation.attachments.type
        messageText.textColor = conversation.attachments.type == "" ? .toasterMetal : .toasterBlue
        unreadLabel.text = "\(conversation.unreadCount)"
        messageTimeLabel.text = conversation.parsingTime
    }
    
    // Установка непрочитанного сообщения
    func setupUnreadMessage(_ conversation: ConversationCore) {
        // Установка непрочитанного исходящего
        if conversation.inRead != conversation.idLastMessage {
            contentView.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.15)
        } else {
            contentView.backgroundColor = UIColor.clear
        }
        // Установка непрочитанного входящего
        if conversation.outRead != conversation.idLastMessage {
            lastMessageViw.backgroundColor = UIColor.toasterBlue.withAlphaComponent(0.15)
        } else {
            lastMessageViw.backgroundColor = UIColor.clear
        }
        // Установка счетчика
        if conversation.unreadCount > 0 {
            unreadCountView.isHidden = false
        } else {
            unreadCountView.isHidden = true
        }
    }
    
    // Установка собеседника и его данных
    func setupInterlocutor(_ conversation: ConversationCore) {
        avatarInterlocutor.kf.setImage(with: URL(string: conversation.photo100))
        nameInterlocutor.text = conversation.userName
        if conversation.online == 1 {
            online.isHidden = false
        } else {
            online.isHidden = true
        }
    }
    
    // Установка отправителя и его данных
    func setupSender(_ conversation: ConversationCore) {
        avatarSender.kf.setImage(with: URL(string: conversation.senderPhoto100))
        if "\(conversation.fromId)" != UserDefaults.standard.string(forKey: "userId") {
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
