//
//  TeamsController.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TeamCell"

class TeamsController: UICollectionViewController, NavigationBarColorable {
    
    var seasonSchedule : Schedule?
    var nbaLogoView : UIImageView?
    
    var navigationTintColor: UIColor? { return UIColor.white }
    var navigationBarTintColor: UIColor? { return UIColor.white }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nbaLogoView = UIImageView(image: UIImage(named: "nba-logo-header"))
        nbaLogoView!.contentMode = .scaleAspectFit
        navigationItem.titleView = nbaLogoView
        
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
    
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamInfoVC = TeamInfoController()
        let team = arrTeams[indexPath.section][indexPath.row]
        teamInfoVC.team = team
        teamInfoVC.teamSchedule = getTeamSchedule(team)
        navigationController?.pushViewController(teamInfoVC, animated: true)
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

