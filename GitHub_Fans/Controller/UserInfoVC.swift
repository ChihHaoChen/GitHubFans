//
//  UserInfoVC.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/14.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
	func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {

	var username: String!
	weak var delegate: UserInfoVCDelegate!
	
	let headerView = UIView()
	let itemViewOne = UIView()
	let itemViewTwo = UIView()
	let dateLabel = GFBodyLabel(textAlignment: .center)
	var itemViews: [UIView] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		layoutUI()
		getUserInfo()
		
    }
	
	func getUserInfo()	{
		NetworkService.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			
			switch result	{
				case .success(let user):
					DispatchQueue.main.async {
						self.populateUIElements(with: user)
					}

				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	func populateUIElements(with user: User) {
		self.addChildView(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
		self.addChildView(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
		self.addChildView(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
		self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
	}
	
	func configureViewController()	{
		view.backgroundColor = .systemBackground
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
		navigationItem.rightBarButtonItem = doneButton
	}
    
	@objc func dismissVC()	{
		dismiss(animated: true)
	}
	
	func layoutUI()	{
		let padding: CGFloat = 20
		let itemHeight: CGFloat = 150
		itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
		
		for itemView in itemViews	{
			view.addSubview(itemView)
			itemView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
				itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
			])
		}
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerView.heightAnchor.constraint(equalToConstant: 210),
			
			itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
			itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
			
			itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
			itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
			
			dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
			dateLabel.heightAnchor.constraint(equalToConstant: 50)
		])
	}
	
	func addChildView(childVC: UIViewController, to containerView: UIView)	{
		addChild(childVC)
		containerView.addSubview(childVC.view)
		childVC.view.frame = containerView.bounds
		childVC.didMove(toParent: self)
	}
}

extension UserInfoVC: GFRepoItemVCDelegate {
	func didTapGitHubProfile(for user: User) {
		guard let url = URL(string: user.htmlUrl) else {
			presentGFAlertOnMainThread(title: "Invalid URL", message: "THE url attached to this user is invalid", buttonTitle: "Ok")
			return
		}
		presentSafariVC(with: url)
	}
}

extension UserInfoVC: GFFollowerItemVCDelegate {
	func didTapGetFollowers(for user: User) {
		guard user.followers != 0 else {
			presentGFAlertOnMainThread(title: "No followers", message: "This user has no followers.", buttonTitle: "Return")
			return
		}
		delegate.didRequestFollowers(for: user.login)
		dismissVC()
	}
}
