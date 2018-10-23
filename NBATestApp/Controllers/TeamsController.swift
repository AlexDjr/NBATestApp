//
//  TeamsController.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TeamCell"

class TeamsController: UICollectionViewController {
    
    var seasonSchedule : Schedule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        customizing navigation bar appearance
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        
        //        customizing status bar
        let statusBarBackgroundView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarBackgroundView.backgroundColor = UIColor(red: 50/255, green: 95/255, blue: 215/255, alpha: 1)
        view.addSubview(statusBarBackgroundView)
        
        collectionView.alwaysBounceVertical = true
        
        APIManager.sharedManager.getSchedule { schedule in
            self.seasonSchedule = schedule
            print("Schedule downloaded")
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTeams[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TeamCell
        
        cell.teamLogo.image = UIImage(named: arrTeams[indexPath.section][indexPath.row].name)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header = DivisionCell()
        if kind == UICollectionView.elementKindSectionHeader {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DivisionCell", for: indexPath) as! DivisionCell
            header.divisionNameLabel.text = Division.fromHashValue(hashValue: indexPath.section)?.rawValue.uppercased() ?? " "
            
        }
        
        return header
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowPlayers" {
            if let indexPaths = self.collectionView.indexPathsForSelectedItems {
                let playersVC = segue.destination as! PlayersController
                playersVC.team = arrTeams[indexPaths[0].section][indexPaths[0].row]
                
            }
        }
        
        if segue.identifier == "ShowTeamInfo" {
            if let indexPaths = self.collectionView.indexPathsForSelectedItems {
                let teamInfoVC = segue.destination as! TeamInfoController
                let team = arrTeams[indexPaths[0].section][indexPaths[0].row]
                teamInfoVC.team = team
                teamInfoVC.teamSchedule = getTeamSchedule(team)
            }
        }
        
    }
    
    
    //    MARK: - Methods
    private func getTeamSchedule(_ team: Team) -> Schedule? {
        
        guard let schedule = seasonSchedule else { return nil}
        
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

