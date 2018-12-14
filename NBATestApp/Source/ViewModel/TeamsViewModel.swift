//
//  TeamsViewModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 17/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class TeamsViewModel {
    
    var titleView: UIView {
        let view = UIImageView(image: UIImage(named: "nba-logo-header"))
        view.contentMode = .scaleAspectFit
        return view
    }
    
    private var selectedIndexPath: IndexPath?
    private var seasonSchedule: Schedule?
    
    func numberOfSections() -> Int {
        return 6
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return arrTeams[section].count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TeamsCellViewModel? {
        return TeamsCellViewModel(team: arrTeams[indexPath.section][indexPath.row])
    }
    
    func sectionHeaderViewModel(forIndexPath indexPath: IndexPath) -> TeamsSectionHeaderViewModel? {
        return TeamsSectionHeaderViewModel(name: Division.fromHashValue(hashValue: indexPath.section)?.rawValue.uppercased() ?? " ")
    }
    
    func viewModelForSelectedItem() -> TeamInfoViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        var team = arrTeams[selectedIndexPath.section][selectedIndexPath.row]
        let schedule = getTeamSchedule(team)
        team.schedule = schedule
        return TeamInfoViewModel(team: team)
    }
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func getSeasonSchedule() {
        APIManager.sharedManager.getSchedule(season: "2018-19") { schedule in
            self.seasonSchedule = schedule
            print("Schedule downloaded")
        }
    }
    
    //    MARK: - Private Methods
    private func getTeamSchedule(_ team: Team) -> Schedule? {
        guard let schedule = seasonSchedule else { return nil }
        
        var months = [ScheduleMonth]()
        let games = [ScheduleGame]()
        
        for (index, month) in schedule.months.enumerated() {
            months.append(ScheduleMonth(name: month.name, games: games))
            for game in month.games {
                if game.homeId == team.id || game.visitorId == team.id {
                    months[index].games.append(game)
                }
            }
        }
        
        let monthWithGames = months.filter { !$0.games.isEmpty }
        return Schedule(months: monthWithGames)
    }
    
}
