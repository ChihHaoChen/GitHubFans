//
//  UIView+Ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/02/05.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		for view in views { addSubview(view) }
	}
}
