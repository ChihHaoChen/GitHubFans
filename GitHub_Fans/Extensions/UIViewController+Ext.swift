//
//  UIViewController+Ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/03.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController	{
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String)	{
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true, completion: nil)
		}
	}
	
	func presentSafariVC(with url: URL) {
		let safaraiVC = SFSafariViewController(url: url)
		safaraiVC.preferredControlTintColor = .systemGreen
		present(safaraiVC, animated: true)
	}
	
	func showLoadingView()	{
		containerView = UIView(frame: view.bounds)
		view.addSubview(containerView)
		
		containerView.backgroundColor = .systemBackground
		containerView.alpha = 0
		
		UIView.animate(withDuration: 0.3) {
			containerView.alpha = 0.8
		}
		
		let activityIndicator = UIActivityIndicatorView(style: .large)
		containerView.addSubview(activityIndicator)
		
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		
		activityIndicator.startAnimating()
	}
	
	func dismissLoadingView()	{
		DispatchQueue.main.async {
			containerView.removeFromSuperview()
			containerView = nil
		}
	}
	
	func showEmptyStateView(with message: String, in view: UIView)	{ // Augment view is to know which view that emptyStateView gonna be attached to
		let emptyStateView = GFEmptyStateView(message: message)
		emptyStateView.frame = view.bounds
		view.addSubview(emptyStateView)
	}
}
