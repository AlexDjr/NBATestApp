//
//  APIManager.swift
//  NBATestApp
//
//  Created by Alex Delin on 03/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class APIManager {
    
   static let sharedManager = APIManager()
    
   func fetchData(fromURL url: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: url) else { return }
    
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if error != nil {
                print(error.debugDescription)
            } else {
                completion(data)
            }
            
            }.resume()
}

    
    func getPlayersOfTeam(id teamID: Int, season: String, completion: @escaping ([Player]) -> ()) {
        
        let url = "https://stats.nba.com/stats/commonteamroster/?Season=\(season)&TeamID=\(teamID)"
        
        fetchData(fromURL: url) { (data) in
            
            do {

                let APIresponse = try JSONDecoder().decode(APIResponse.self, from: data!)

                let playersFromAPI = APIresponse.resultSets[0].rowSet
                var players = [Player]()

                for i in playersFromAPI.indices {
                    let playerInfo = playersFromAPI[i].get() as! [APIRowSet]
                    
                    let player = Player.init(teamID: playerInfo[0].get() as! Int,
                                             season: playerInfo[1].get() as! String,
                                             leagueID: playerInfo[2].get() as! String,
                                             fullName: playerInfo[3].get() as! String,
                                             number: playerInfo[4].get() as! String,
                                             position: playerInfo[5].get() as! String,
                                             height: playerInfo[6].get() as! String,
                                             weight: playerInfo[7].get() as! String,
                                             birthDate: playerInfo[8].get() as! String,
                                             age: playerInfo[9].get() as! Int,
                                             expirience: playerInfo[10].get() as! String,
                                             school: playerInfo[11].get() as! String,
                                             playerID: playerInfo[12].get() as! Int,
                                             photo: nil)
                    players.append(player)
                }
                completion(players)

            } catch let error {
                print("Error serialization json: ", error)
            }
            
        }
        
    }

    
    func getPlayersPhoto(_ players: [Player], completion: @escaping ([UIImage]) -> ()) {
        
        var imageURLs = [String]()
        
        for player in players {
            if let firstName = player.firstName {
                imageURLs.append("https://nba-players.herokuapp.com/players/\(player.lastName)/\(firstName)")
            } else {
                imageURLs.append("https://nba-players.herokuapp.com/players/\(player.lastName)")
            }
        }
        
        getImagesFromURLs(imageURLs) { (images : [UIImage], imgCount : Int) in
//            returning only when images for each player have been added
            if imgCount == players.count {
                completion(images)
            }
        }
      
    }
    
    private func getImagesFromURLs (_ imageURLs: [String], completion: @escaping ([UIImage], Int) -> ()) {
        
        var images = [UIImage](repeating: UIImage(named: "no-photo")!, count: imageURLs.count)
        var imgCount = 0
        
        for (index, url) in imageURLs.enumerated() {
            self.fetchData(fromURL: url) { (data) in
                if let image = UIImage(data: data!) {
                    images[index] = image
                }
                imgCount += 1
                completion(images, imgCount)
            }
        }
    }
    
    func getSchedule(season: String, completion: @escaping (Schedule?) ->()) {
        let year = String(season.prefix(4))
        let url = "https://data.nba.com/data/10s/v2015/json/mobile_teams/nba/\(year)/league/00_full_schedule.json"
        
        fetchData(fromURL: url) { (data) in
        
            do {
                
                let APIResponse = try JSONDecoder().decode(SCDAPIResponse.self, from: data!)
                let monthSCDArray = APIResponse.lscd
                
                var months = [ScheduleMonth]()
                
                for (index, monthSCD) in monthSCDArray.enumerated() {
                    var games = [ScheduleGame]()
                    for gameSCD in monthSCDArray[index].mscd.g {
                        
                        let game = ScheduleGame.init(id: gameSCD.gid,
                                                     code: gameSCD.gcode,
                                                     timeEST: gameSCD.etm,
                                                     date: gameSCD.gdte,
                                                     type: ScheduleGame.GameType.init(rawValue: String(gameSCD.gid.prefix(3)))!,
                                                     homeId: gameSCD.h.tid,
                                                     homeRecord: gameSCD.h.re,
                                                     homeScore: gameSCD.h.s,
                                                     visitorId: gameSCD.v.tid,
                                                     visitorRecord: gameSCD.v.re,
                                                     visitorScore: gameSCD.v.s)
                        games.append(game)
                    }
                    let month = ScheduleMonth.init(name: monthSCD.mscd.mon, games: games)
                    months.append(month)
                }
                
                let schedule = Schedule.init(months: months)
                
                completion(schedule)
                
            } catch let error {
                print("Error serialization json: ", error)
                completion(nil)
            }
            
        }
    }
    
    func getTeamSchedule(_ team: Team, season: String, completion: @escaping (Schedule?) ->()) {
        getSchedule(season: season) { schedule in
            if let schedule = schedule {
                var monthsTeam = [ScheduleMonth]()
                let gamesTeam = [ScheduleGame]()
                
                for (index, month) in schedule.months.enumerated() {
                    monthsTeam.append(ScheduleMonth(name: month.name, games: gamesTeam))
                    for game in month.games {
                        if game.homeId == team.id || game.visitorId == team.id {
                            monthsTeam[index].games.append(game)
                        }
                    }
                }
                let monthsWithGames = monthsTeam.filter { !$0.games.isEmpty }
                let teamSchedule = Schedule(months: monthsWithGames)
                completion(teamSchedule)
            } else {
                completion(nil)
            }
        }
    }
    

    
}
