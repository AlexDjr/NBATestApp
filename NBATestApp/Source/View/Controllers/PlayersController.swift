//
//  PlayersController.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayersController: UITableViewController {
    
    var viewModel: PlayersViewModel?
    
    let spinner = UIActivityIndicatorView()
    var loadingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        
        setLoadingScreen()
        
        guard let viewModel = viewModel else { return }
        viewModel.getPlayers { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.removeLoadingScreen()
            }
        }
    }
    
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell
        
        guard let playerCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        playerCell.viewModel = cellViewModel
        
        return playerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRowAt(forIndexPath: indexPath) ?? 44
    }
    
    
    //    MARK: - UI Methods
    func updateTableForSeason(_ value: String) {
        if viewModel?.season.value != value {
            //            season = value
            self.viewModel?.season.value = value
            
            if loadingView.isHidden == false {
                removeLoadingScreen()
            }
            
            setLoadingScreen()
            
            guard let viewModel = viewModel else { return }
            viewModel.getPlayers { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.removeLoadingScreen()
                }
            }
        }
    }
    
    private func setLoadingScreen() {
        let x : CGFloat = 0
        let y : CGFloat = 0
        let width : CGFloat = tableView.frame.width
        let height : CGFloat = tableView.frame.height
        let newLoadingView = UIView()
        newLoadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        newLoadingView.backgroundColor = UIColor.white
        
        spinner.style = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        spinner.center = newLoadingView.center
        
        newLoadingView.addSubview(spinner)
        tableView.addSubview(newLoadingView)
        
        tableView.isScrollEnabled = false
        if !tableView.visibleCells.isEmpty {
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
        }
        
        loadingView = newLoadingView
        
    }
    
    private func removeLoadingScreen() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingView.isHidden = true
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
    }
    
}
