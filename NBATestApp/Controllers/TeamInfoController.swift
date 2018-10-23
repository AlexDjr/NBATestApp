//
//  TeamInfoViewController.swift
//  NBATestApp
//
//  Created by Alex Delin on 17/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamInfoController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var team : Team?
    var teamSchedule : Schedule?
    
    var navBarTitleView : TeamInfoNavBarTitleView?
    
    var teamInfoSegmentedControl = TeamInfoSegmentedControl()
    let teamMenuBar = TeamMenuBarView()
    var navBarHeight : CGFloat = 0
    
    var teamInfoView: UICollectionView!
    
    private lazy var rosterVC: PlayersController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "PlayersController") as! PlayersController
        viewController.team = team
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var scheduleVC: ScheduleController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ScheduleController") as! ScheduleController
        viewController.team = team
        viewController.teamSchedule = teamSchedule
        self.add(asChildViewController: viewController)
        return viewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStatusBar()
        setupNavBar()
        setupTeamMenuBar()
        
        setupTeamInfoView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navBarTitleView?.isHidden = true
    }
    
    
    //    MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamInfoView.dequeueReusableCell(withReuseIdentifier: TeamInfoCell.reuseIdentifier, for: indexPath) as! TeamInfoCell
        cell.backgroundColor = UIColor.red
        
        switch indexPath.row {
        case 0: cell.hostedView = scheduleVC.tableView
        case 1: cell.hostedView = rosterVC.tableView
        default: break
        }
        return cell
    }
    
    
    //    MARK: - UICollectionViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Int(scrollView.contentOffset.x) % Int(view.frame.width) == 0 {
            teamInfoSegmentedControl.selectedSegmentIndex = Int(scrollView.contentOffset.x / view.frame.width)
            teamInfoSegmentedControl.sendActions(for: .valueChanged)
        }
    }
    
    
    //    MARK: - Methods
    private func setupStatusBar() {
        let statusBarBackgroundView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarBackgroundView.backgroundColor = UIColor(red: 50/255, green: 95/255, blue: 215/255, alpha: 1)
        view.addSubview(statusBarBackgroundView)
    }
    
    private func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            if let team = team {
                navBarTitleView = TeamInfoNavBarTitleView(teamName: team.fullName, season: "2018-19")
                navBar.addSubview(navBarTitleView!)
                navBarTitleView!.translatesAutoresizingMaskIntoConstraints = false
                navBarTitleView!.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
                navBarTitleView!.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
                navBarTitleView!.seasonButton.addTarget(self, action: #selector(chooseSeason), for: .touchUpInside)
            }
            navBarHeight = navBar.frame.height + UIApplication.shared.keyWindow!.safeAreaInsets.top
        }
    }
    
    private func setupTeamMenuBar() {
        view.addSubview(teamMenuBar)
        teamMenuBar.translatesAutoresizingMaskIntoConstraints = false
        teamMenuBar.topAnchor.constraint(equalTo: view.topAnchor, constant: navBarHeight).isActive = true
        teamMenuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        teamMenuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        teamMenuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        teamMenuBar.addSubview(teamInfoSegmentedControl)
        teamInfoSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        teamInfoSegmentedControl.centerXAnchor.constraint(equalTo: teamMenuBar.centerXAnchor).isActive = true
        teamInfoSegmentedControl.bottomAnchor.constraint(equalTo: teamMenuBar.bottomAnchor).isActive = true
        teamInfoSegmentedControl.addTarget(self, action: #selector(teamInfoSegmentedControlChanged(_:)), for: .valueChanged)
    }
    
    private func setupTeamInfoView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - navBarHeight - 40)
        
        teamInfoView = UICollectionView(frame: CGRect(x: 0, y: navBarHeight + 40, width: view.frame.width, height: view.frame.height - navBarHeight - 40), collectionViewLayout: layout)
        teamInfoView.isPagingEnabled = true
        teamInfoView.backgroundColor = UIColor.white
        teamInfoView.dataSource = self
        teamInfoView.delegate = self
        view.addSubview(teamInfoView)
        
        teamInfoView.register(TeamInfoCell.self, forCellWithReuseIdentifier: TeamInfoCell.reuseIdentifier)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    @objc private func teamInfoSegmentedControlChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.teamInfoSegmentedControl.bottomBar.frame.origin.x = (self.teamInfoSegmentedControl.frame.width / CGFloat(self.teamInfoSegmentedControl.numberOfSegments)) * CGFloat(self.teamInfoSegmentedControl.selectedSegmentIndex)
            
            //            moving collection view to needed cell
            let indexPath = IndexPath(item: self.teamInfoSegmentedControl.selectedSegmentIndex, section: 0)
            self.teamInfoView.scrollToItem(at: indexPath, at: [], animated: true)
        }
    }
    
    @objc private func chooseSeason() {
        rosterVC.chooseSeason()
    }
    
}
