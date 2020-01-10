//
//  FollowerCell.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/09.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func set(follower: Follower)	{
		usernameLabel.text = follower.login
	}
	
	private func configure()	{
		addSubview(avatarImageView)
		addSubview(usernameLabel)

		let padding: CGFloat = 8
		let spacing: CGFloat = 12
		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: spacing),
			usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			usernameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}
