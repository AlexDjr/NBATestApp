//
//  APIManager.swift
//  NBATestApp
//
//  Created by Alex Delin on 03/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class APIManager {
    
   static var sharedManager = APIManager()
    
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

    
    func getPlayersOfTeam(id teamID: Int, completion: @escaping ([Player]) -> ()) {
        
        let url = "https://stats.nba.com/stats/commonteamroster/?Season=2018-19&TeamID=\(teamID)"
        
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
//            возвращаем в PlayersController массив с картинками только тогда,
//            когда были загружены картинки для каждого игрока
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
    

    
}
