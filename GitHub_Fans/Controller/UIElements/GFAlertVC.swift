//
//  GFAlertVC.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/02.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
	
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
	
    var padding: CGFloat = 20
	
    
    init(alertTitle: String, message: String, buttonTitle: String)   {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
	
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureUIElements()
    }
	
	
    // MARK: - Configure the UI elements in AlertView Container
	func configureUIElements()	{
		view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
		
		configureContainerView()
		configureTitleLabel()
		configureActionButton()
		configureMessageLabel()
	}
	
	
    func configureContainerView()   {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

	
    func configureTitleLabel()  {
        titleLabel.text = alertTitle ?? "Some other title"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
	
    func configureActionButton()  {
		actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
		
		actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
			actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
			actionButton.heightAnchor.constraint(equalToConstant: 44)
		])
    }
	
	
	@objc func dismissVC()	{
		dismiss(animated: true, completion: nil)
	}
	
	
	func configureMessageLabel()	{
		messageLabel.text = message ?? "Unable to complete the request"
		messageLabel.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -8),
			messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
			messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
		])
	}
}
