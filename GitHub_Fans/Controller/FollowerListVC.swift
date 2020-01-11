//
//  FollowerListVC.swift
//  GitHub_Fans
//
//  Created by ChihHao on 2020/01/02.
//  Copyright © 2020 ChihHao. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
	
	enum Section	{ // enum is hashable
		case main
	}
	
    var username: String?
	var followers: [Follower] = []
	
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
        configureCollectionView()
		
		getFollowers()
		configureDataSource()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	// MARK: - Configuration of UI Elements
	func configureViewController()	{
		view.backgroundColor = .systemBackground
			   navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func configureCollectionView()	{
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	// MARK: - API Requests
	func getFollowers()	{
		guard let usernameForAPI = username else { return }
		
		NetworkService.shared.getFollowers(for: usernameForAPI, page: 1) { [weak self] (result) in
			guard let self = self else	{ return }	// Introduced in Swift 4.2
			
			switch result	{
				case .success(let followers):
					self.followers = followers
					self.updateData()
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Issues of the API requests", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
	
	// MARK: - Configure Data Source
	func configureDataSource()	{
		dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
			cell.set(follower: follower)
			
			return cell
		})
	}
	
	func updateData()	{
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async { // put apply into the main thread
			self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
		}
	}
}
