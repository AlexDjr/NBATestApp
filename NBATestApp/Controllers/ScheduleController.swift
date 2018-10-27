//
//  ScheduleController.swift
//  NBATestApp
//
//  Created by Alex Delin on 19/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class ScheduleController: UITableViewController {
    
    var team : Team?
    var teamSchedule : Schedule?
    var season = "2018-19"
    let spinner = UIActivityIndicatorView()
    var loadingView = UIView()
    
    var parentVC : TeamInfoController?
    var navBarIsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return teamSchedule?.months.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamSchedule?.months[section].games.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleGameCell", for: indexPath) as! ScheduleGameCell
        
        guard let schedule = teamSchedule else { return cell }
        
        let game = schedule.months[indexPath.section].games[indexPath.row]
        
        var visitorTeamName = ""
        var homeTeamName = ""
        
        if game.homeId == team!.id {
            homeTeamName = team!.name
            visitorTeamName = Team.getTeamNameById(game.visitorId) ?? "no-logo"
        } else {
            homeTeamName = Team.getTeamNameById(game.homeId) ?? "no-logo"
            visitorTeamName = team!.name
        }
        
        cell.visitorScore.text = game.visitorScore.count == 0 ? "-" : game.visitorScore
        cell.homeScore.text = game.homeScore.count == 0 ? "-" : game.homeScore
        cell.gameDate.text = game.date
        cell.visitorLogo.image = UIImage(named: visitorTeamName)
        cell.homeLogo.image = UIImage(named: homeTeamName)
        cell.visitorRecord.text = game.visitorRecord
        cell.homeRecord.text = game.homeRecord
        
        if game.timeEST.contains("T") {
            let index = game.timeEST.lastIndex(of: "T")!
            cell.gameTime.text = String(game.timeEST.suffix(from: index))
        }
        return cell
    }
    
    
    //    MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teamSchedule?.months[section].name ?? ""
    }
    
    
    //    MARK: - UIScrollViewDelegate
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if navBarIsHidden == true && targetContentOffset.pointee.y < scrollView.contentOffset.y && velocity.y <= -1.3 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navBarIsHidden = false
            //  calling this to re-lay content (particylary items height) in collection view
            parentVC?.teamInfoView.collectionViewLayout.invalidateLayout()
        } else if navBarIsHidden == false && targetContentOffset.pointee.y > scrollView.contentOffset.y && velocity.y >= 1.3 {
            navigationController?.setNavigationBarHidden(true, animated: true)
            navBarIsHidden = true
            parentVC?.teamInfoView.collectionViewLayout.invalidateLayout()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if navBarIsHidden == true && scrollView.contentOffset.y <= 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
            navBarIsHidden = false
            parentVC?.teamInfoView.collectionViewLayout.invalidateLayout()
        }
    }
    
    
    //    MARK: - API GET Methods
    private func getSchedule() {
        APIManager.sharedManager.getTeamSchedule(team!, season: season) { schedule in
            if let teamSchedule = schedule {
                DispatchQueue.main.async {
                    self.teamSchedule = teamSchedule
                    self.tableView.reloadData()
                    self.removeLoadingScreen()
                }
            } else {
                DispatchQueue.main.async {
                    self.teamSchedule = nil
                    
                    let alert = UIAlertController(title: nil, message: "No schedule available for this season", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .default, handler: { alert in
                        self.tableView.reloadData()
                        self.removeLoadingScreen()
                    })
                    
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    //    MARK: - UI Methods
    func updateTableForSeason(_ value: String) {
        if season != value {
            season = value
            
            if loadingView.isHidden == false {
                removeLoadingScreen()
            }
            setLoadingScreen()
            getSchedule()
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
