//
//  TeamInfoViewController.swift
//  NBATestApp
//
//  Created by Alex Delin on 17/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamInfoController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NavigationBarColorable {
    
    var team : Team?
    var teamSchedule : Schedule?
    
    var navBarTitleView : TeamInfoNavBarTitleView?
    
    var teamInfoSegmentedControl = TeamInfoSegmentedControl()
    let teamMenuBar = TeamMenuBarView()
    
    var teamInfoView: UICollectionView!
    
    var navigationTintColor: UIColor? { return UIColor.white }
    var navigationBarTintColor: UIColor? { return team?.primaryColor}
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        viewController.parentVC = self
        self.add(asChildViewController: viewController)
        return viewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = team?.primaryColor
        
        setupNavBar()
        setupTeamMenuBar()
        
        setupTeamInfoView()
        
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    }
    
    
    //    MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = teamInfoView.dequeueReusableCell(withReuseIdentifier: TeamInfoCell.reuseIdentifier, for: indexPath) as! TeamInfoCell
        cell.backgroundColor = UIColor.white
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    //    MARK: - Methods
    private func setupNavBar() {
        if let team = team {
            navBarTitleView = TeamInfoNavBarTitleView(teamName: team.fullName, season: "2018-19")
            navigationItem.titleView = navBarTitleView
            navBarTitleView!.seasonButton.addTarget(self, action: #selector(chooseSeason), for: .touchUpInside)
        }
    }
    
    private func setupTeamMenuBar() {
        view.addSubview(teamMenuBar)
        teamMenuBar.translatesAutoresizingMaskIntoConstraints = false
        teamMenuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        teamMenuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        teamMenuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        teamMenuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        if let team = team {
            teamInfoSegmentedControl = TeamInfoSegmentedControl(color: team.secondColor)
            teamMenuBar.backgroundColor = team.primaryColor
        }
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
        
        teamInfoView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        teamInfoView.isPagingEnabled = true
        teamInfoView.backgroundColor = UIColor.white
        teamInfoView.dataSource = self
        teamInfoView.delegate = self
        view.addSubview(teamInfoView)
        
        teamInfoView.translatesAutoresizingMaskIntoConstraints = false
        teamInfoView.topAnchor.constraint(equalTo: teamMenuBar.bottomAnchor).isActive = true
        teamInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        teamInfoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        teamInfoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
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
            
            //  moving collection view to needed cell
            let indexPath = IndexPath(item: self.teamInfoSegmentedControl.selectedSegmentIndex, section: 0)
            self.teamInfoView.scrollToItem(at: indexPath, at: [], animated: true)
        }
    }
    
    @objc private func chooseSeason() {
        rosterVC.chooseSeason()
    }
    
}
