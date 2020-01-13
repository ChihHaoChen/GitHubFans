//
//  UIViewController+Ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/03.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

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
}
