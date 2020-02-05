//
//  GFBodyLabel.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/02.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
		configure()
    }
    
	
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
	
    private func configure()  {
        textColor = .secondaryLabel
		// dynamic type: next two lines
        font = UIFont.preferredFont(forTextStyle: .body)
		adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
