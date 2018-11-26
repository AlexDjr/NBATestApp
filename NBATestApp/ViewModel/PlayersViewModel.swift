//
//  PlayersViewModel.swift
//  NBATestApp_mvvm
//
//  Created by Alex Delin on 25/11/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayersViewModel {
    var team: Team?
    var season : Box<String> = Box("2018-19")
    var players : [Player]?
    
    init(team: Team) {
        self.team = team
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return players?.count ?? 1
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PlayersCellViewModel? {
        guard let players = players else { return nil }
        return PlayersCellViewModel(player: players[indexPath.row])
    }
    
    func heightForRowAt(forIndexPath indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //    MARK: - Methods
    func getPlayers(completion: @escaping () -> ()) {
        APIManager.sharedManager.getPlayersOfTeam(id: team!.id, season: season.value) { (players : [Player]) in
            self.players = players
            self.getPlayersPhoto(completion: {
                completion()
            })
        }
    }
    
    private func getPlayersPhoto(completion: @escaping () -> ()) {
        if players == nil {
            print("Error: array of players is nil" )
        } else {
            APIManager.sharedManager.getPlayersPhoto(players!) { (images : [UIImage]) in
                DispatchQueue.main.async {
                    
                    for index in self.players!.indices {
                        self.players![index].photo = images[index]
                    }
                    completion()
                }
            }
        }
    }
    
}
