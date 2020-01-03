//
//  UIViewController+Ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/03.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

extension UIViewController	{
	func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String)	{
		DispatchQueue.main.async {
			let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
			alertVC.modalPresentationStyle = .overFullScreen
			alertVC.modalTransitionStyle = .crossDissolve
			self.present(alertVC, animated: true, completion: nil)
		}
	}
}
