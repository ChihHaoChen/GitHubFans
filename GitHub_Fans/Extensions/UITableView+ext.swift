//
//  UITableView+ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/02/05.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

extension UITableView {
	
	func removeExcessCells() {
		tableFooterView = UIView(frame: .zero)
	}
	
	func reloadDataOnMainThread() {
		DispatchQueue.main.async {
			self.reloadData()
		}
	}
}
