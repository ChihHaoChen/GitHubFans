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
	
    var username: String!
	var followers: [Follower] = []
	var filteredFollowers: [Follower] = []
	var page: Int = 1
	var hasMoreFollowers = true
	
	var collectionView: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		configureViewController()
		configureSearchController()
        configureCollectionView()
		getFollowers(username: username, page: page)
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
		collectionView.delegate = self
		collectionView.backgroundColor = .systemBackground
		collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
	}
	
	// MARK: - Configuration of searchController
	func configureSearchController()	{
		let searchController = UISearchController()
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Search for a username"
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.searchController = searchController
	}
	
	// MARK: - API Requests
	func getFollowers(username: String, page: Int)	{
		showLoadingView()
		NetworkService.shared.getFollowers(for: username, page: page) { [weak self] (result) in
			guard let self = self else	{ return }	// Introduced in Swift 4.2
			self.dismissLoadingView()
			
			switch result	{
				case .success(let followers):
					if followers.count < 100	{ self.hasMoreFollowers = false }
					self.followers.append(contentsOf: followers)
					
					if self.followers.isEmpty	{
						let message = "This user does not have any followers. Go follow them 🥰."
						DispatchQueue.main.async {
							self.showEmptyStateView(with: message, in: self.view)
						}
						return
					}
					self.updateData(on: self.followers)
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
	
	func updateData(on followers: [Follower])	{
		var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
		snapshot.appendSections([.main])
		snapshot.appendItems(followers)
		DispatchQueue.main.async { // put apply into the main thread
			self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
		}
	}
}
	// MARK: - Extension for pagination
extension FollowerListVC: UICollectionViewDelegate	{
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		let height = scrollView.frame.size.height
		
		if offsetY > contentHeight - height	{
			guard hasMoreFollowers else { return }
			page += 1
			getFollowers(username: username, page: page)
		}
	}
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate	{
	func updateSearchResults(for searchController: UISearchController) {
		guard let filterText = searchController.searchBar.text, !filterText.isEmpty else { return }
		
		filteredFollowers = followers.filter { $0.login.lowercased().contains(filterText.lowercased()) }
		updateData(on: filteredFollowers)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		updateData(on: followers)
	}
}
