//
//  ScheduleController.swift
//  NBATestApp
//
//  Created by Alex Delin on 19/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class ScheduleController: UITableViewController {
    
    var viewModel: ScheduleViewModel?

    let spinner = UIActivityIndicatorView()
    var loadingView = UIView()
    
    var parentController : TeamInfoController?
    var navBarIsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
    
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleGameCell", for: indexPath) as? ScheduleGameCell
        
        guard let scheduleGameCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        scheduleGameCell.viewModel = cellViewModel
        
        return scheduleGameCell
    }
    
    
    //    MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightForRowAt(forIndexPath: indexPath) ?? 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.titleForHeaderInSection(section) ?? ""
    }
    
    
    //    MARK: - UIScrollViewDelegate
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if navBarIsHidden == true && targetContentOffset.pointee.y < scrollView.contentOffset.y && velocity.y <= -1.3 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navBarIsHidden = false
            //  calling this to re-lay content (particulary items height) in collection view
            parentController?.teamInfoView.collectionViewLayout.invalidateLayout()
        } else if navBarIsHidden == false && targetContentOffset.pointee.y > scrollView.contentOffset.y && velocity.y >= 1.3 {
            navigationController?.setNavigationBarHidden(true, animated: true)
            navBarIsHidden = true
            parentController?.teamInfoView.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if navBarIsHidden == true && scrollView.contentOffset.y <= 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navBarIsHidden = false
            parentController?.teamInfoView.collectionViewLayout.invalidateLayout()
        }
    }
    
    
    //    MARK: - UI Methods
    func updateTableForSeason(_ value: String) {
        if viewModel?.season.value != value {
            self.viewModel?.season.value = value
            
            if loadingView.isHidden == false {
                removeLoadingScreen()
            }
            setLoadingScreen()
            guard let viewModel = viewModel else { return }
            viewModel.getSchedule { [weak self] schedule in
                if schedule != nil {
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.removeLoadingScreen()
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: nil, message: "No schedule available for this season", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: { alert in
                            self?.tableView.reloadData()
                            self?.removeLoadingScreen()
                        })
                        
                        alert.addAction(cancelAction)
                        self?.present(alert, animated: true, completion: nil)
                    }
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
