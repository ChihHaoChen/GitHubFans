//
//  String+Ext.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/29.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import Foundation

extension String	{
	func convertToDate() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.timeZone = .current
		
		return dateFormatter.date(from: self)
	}
	
	
	func convertToDisplayFormat() -> String	{
		guard let date = self.convertToDate() else { return "N/A" }
		return date.convertToMonthYearFormat()
	}
}
