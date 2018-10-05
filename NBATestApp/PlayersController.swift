//
//  PlayersController.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayersController: UITableViewController {

    var team : Team?
    var players : [Player]?
    
    let spinner = UIActivityIndicatorView()
    let loadingView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = team?.fullName ?? "Roster"
        self.tableView.separatorStyle = .none
        
        setLoadingScreen()
        getPlayers()
    
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell

        cell.playerName.text = players?[indexPath.row].fullName
        cell.playerNumber.text = players?[indexPath.row].number
        cell.playerPosition.text = players?[indexPath.row].position
        cell.playerAge.text = String(players?[indexPath.row].age ?? 0)
        cell.playerHeight.text = players?[indexPath.row].height
        cell.playerWeight.text = players?[indexPath.row].weight
        cell.playerExpirience.text = players?[indexPath.row].expirience
        cell.playerPhoto.image = players?[indexPath.row].photo!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
//    MARK: - GET Methods
    fileprivate func getPlayers() {
        APIManager.sharedManager.getPlayersOfTeam(id: team!.id) { (players : [Player]) in
            self.players = players
            self.getPlayersPhoto()
        }
    }
    
    fileprivate func getPlayersPhoto() {
        if players == nil {
            print("Error: array of players is nil" )
        } else {
                APIManager.sharedManager.getPlayersPhoto(players!) { (images : [UIImage]) in
                    DispatchQueue.main.async {
                        
                        for index in self.players!.indices {
                            self.players![index].photo = images[index]
                        }
                        
                        self.tableView.reloadData()
                        self.removeLoadingScreen()
                    }
                }
        }

    }
    
    
//    MARK: - UI Methods
    fileprivate func setLoadingScreen() {
        
        let x : CGFloat = 0
        let y : CGFloat = 0 - (navigationController?.navigationBar.frame.height)!
        let width : CGFloat = tableView.frame.width
        let height : CGFloat = tableView.frame.height
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        loadingView.backgroundColor = UIColor.white
        
        spinner.style = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        spinner.center = loadingView.center
        
        loadingView.addSubview(spinner)
        self.tableView.addSubview(loadingView)
        
    }
    
    fileprivate func removeLoadingScreen() {
        
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingView.isHidden = true
        self.tableView.separatorStyle = .singleLine
        
    }
    
}
