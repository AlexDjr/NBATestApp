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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return teamSchedule?.months[section].name ?? ""
    }
    
}