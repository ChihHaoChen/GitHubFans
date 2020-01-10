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
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
		view.addSubview(collectionView)
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout	{
		let width = view.bounds.width
		let padding: CGFloat = 12
		let minimumItemSpacing: CGFloat = 10
		let availableWidth = width - 2*padding - 2*minimumItemSpacing
		let itemWidth = availableWidth/3
		
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
		
		return flowLayout
	}
	
	// MARK: - API Requests
	func getFollowers()	{
		guard let usernameForAPI = username else { return }
		
		NetworkService.shared.getFollowers(for: usernameForAPI, page: 1) { (result) in
			
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
