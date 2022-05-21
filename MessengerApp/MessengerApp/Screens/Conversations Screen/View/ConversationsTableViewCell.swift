//
//  ConversationsTableViewCell.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 07.03.2022.
//

import UIKit
import SDWebImage

class ConversationsTableViewCell: UITableViewCell {
    
    static let identifier = "ConversationsTableViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let latestMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let nameAndDateStackView: UIStackView = {
        let stackView  = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        nameAndDateStackView.addArrangedSubview(fullNameLabel)
        nameAndDateStackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(nameAndDateStackView)
        contentView.addSubview(userImageView)
        contentView.addSubview(latestMessageLabel)
    }
    
    private func setupConstraints() {
        userImageView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             topConstant: 10,
                             leftConstant: 10,
                             widthConstant: 70,
                             heightConstant: 70)
        
        nameAndDateStackView.anchor(top: contentView.topAnchor,
                                    left: userImageView.rightAnchor,
                                    right: contentView.rightAnchor,
                                    topConstant: 10,
                                    leftConstant: 10,
                                    rightConstant: 5,
                                    heightConstant: 25)
        
        latestMessageLabel.anchor(top: fullNameLabel.bottomAnchor,
                                  left: userImageView.rightAnchor,
                                  right: contentView.rightAnchor,
                                  leftConstant: 10,
                                  rightConstant: 5)
    }
    
    public func configure(with conversation: Conversation) {
        fullNameLabel.text = conversation.otherUserFullName
        latestMessageLabel.text = conversation.latestMessage.content + "·"
        dateLabel.text = getDateFormat(conversation.latestMessage.date)
        setupProfilePicture(for: conversation.otherUserEmail)
        
        if !conversation.latestMessage.isRead {
            latestMessageLabel.font = .systemFont(ofSize: 15, weight: .bold)
        } else {
            latestMessageLabel.font = .systemFont(ofSize: 15, weight: .thin)
        }
    }
    
    private func setupProfilePicture(for email: String) {
        let filename = email + "_profile_picture.png"
        let path = "images/" + filename
        
        StorageManager.shared.getDownloadURL(for: path, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    self.userImageView.sd_setImage(with: url)
                }
                
            case . failure(let error):
                print("Failed to get download url: \(error)")
            }
        })
    }
    
    private func getDateFormat(_ dateString: String) -> String {
        if let date = DateHelper.dateFormatter.date(from: dateString) {
            // if it's the same day
            if Calendar.current.isDate(date, inSameDayAs: Date()) {
                return String(dateString.suffix(8).dropLast(3))
            } else {
                return String(dateString.dropLast(14))
            }
        }
        return String(dateString.dropLast(3))
    }
    
}
