//
//  Date+Ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/29.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

extension Date	{
	
	func convertToMonthYearFormat()	-> String	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM yyyy"
		
		return dateFormatter.string(from: self)
	}
}
