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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true
        
        APIManager.sharedManager.getSchedule { schedule in
            print(schedule)
        }
    }

    
    // MARK: UICollectionViewDataSource
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
        
     }
 

}
