//
//  ScheduleViewModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 18/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class ScheduleViewModel {
    var team: Team?
    var season : Box<String> = Box("2018-19")
    
    init(team: Team) {
        self.team = team
    }
    
    
    func numberOfSections() -> Int {
        return team?.schedule?.months.count ?? 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return team?.schedule?.months[section].games.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ScheduleGameCellViewModel? {
        guard let team = team, let schedule = team.schedule else { return nil }
        let game = schedule.months[indexPath.section].games[indexPath.row]
        return ScheduleGameCellViewModel(team: team, game: game)
    }
    
    func heightForRowAt(forIndexPath indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func titleForHeaderInSection (_ section: Int) -> String? {
        return team?.schedule?.months[section].name ?? ""
    }
    
    //    MARK: - Methods
    func getSchedule(completion: @escaping (Schedule?) -> ()) {
        guard let team = team else { return }
        APIManager.sharedManager.getTeamSchedule(team, season: season.value) { schedule in
            self.team?.schedule = schedule
            completion(schedule)
        }
    }
    
}
