//
//  TeamsController.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

private let cellIdentifier = "TeamCell"
private let sectionHeaderIdentifier = "DivisionCell"

class TeamsController: UICollectionViewController, NavigationBarColorable {
    
    private var viewModel: TeamsViewModel?
    
    var navigationTintColor: UIColor? { return UIColor.white }
    var navigationBarTintColor: UIColor? { return UIColor.white }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TeamsViewModel()
        viewModel?.getSeasonSchedule()
        navigationItem.titleView = viewModel?.titleView
        collectionView.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navController = navigationController {
            if navController.navigationBar.isHidden {
                navController.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections() ?? 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section) ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? TeamCell
        
        guard let teamCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        teamCell.viewModel = cellViewModel
        
        return teamCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header = DivisionCell()
        if kind == UICollectionView.elementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifier, for: indexPath) as! DivisionCell
            guard let viewModel = viewModel else { return UICollectionReusableView() }
            let headerViewModel = viewModel.sectionHeaderViewModel(forIndexPath: indexPath)
            
            header.viewModel = headerViewModel
        }
        return header
    }
    
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamInfoController = TeamInfoController()
        
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        teamInfoController.viewModel = viewModel.viewModelForSelectedItem()
        
        navigationController?.pushViewController(teamInfoController, animated: true)
    }
    
    
}

