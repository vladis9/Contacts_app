//
//  ContactsViewController.swift
//  Contacts_app
//
//  Created by Vlad Zinevich on 09.08.2021.
//

import UIKit

class ContactsViewController: UIViewController {
    
    let profile = User(fullname: "Vlad Zinevich", imageString: "human1", firstCharacter: "V", id: 20)
    let favouriteUsers = Bundle.main.decode([User].self, from: "favouriteUsers.json")
    let contactsUsers = Bundle.main.decode([User].self, from: "contactUsers.json")
    
    let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonItemTapped))
    let groupsBarButtonItem = UIBarButtonItem(title: "Groups", style: .plain, target: self, action: #selector(addBarButtonItemTapped))
    
    enum Section: Int {
        case profile
        case favourites
        case contacts
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, User>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, User>! = nil
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    private func setupNavigationBar() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.leftBarButtonItem = groupsBarButtonItem
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Contacts"
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .gray
        view.addSubview(collectionView)
        
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseId)
        collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.reuseId)
        collectionView.register(ContactsCell.self, forCellWithReuseIdentifier: ContactsCell.reuseId)
    }
    
    private func reloadData() {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, User>()
        
        currentSnapshot.appendSections([.profile, .favourites, .contacts])
        currentSnapshot.appendItems([profile], toSection: .profile)
        currentSnapshot.appendItems(favouriteUsers, toSection: .favourites)
        currentSnapshot.appendItems(contactsUsers, toSection: .contacts)
        
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    // MARK: - DataSource
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section type") }
            
            switch section {
            case .profile:
                return self.configure(collectionView: collectionView, cellType: ProfileCell.self, with: user, for: indexPath)
            case .favourites:
                return self.configure(collectionView: collectionView, cellType: FavouriteCell.self, with: user, for: indexPath)
            case .contacts:
                return self.configure(collectionView: collectionView, cellType: ContactsCell.self, with: user, for: indexPath)
            }
        })
    }
}

// MARK: - Actions
extension ContactsViewController {
    @objc func addBarButtonItemTapped() {
        print(#function)
    }
    @objc func groupsBarButtonItemTapped() {
        print(#function)
    }
}

// MARK: - UISearchBarDelegate
extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

