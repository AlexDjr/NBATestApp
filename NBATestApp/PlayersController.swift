//
//  PlayersController.swift
//  NBATestApp
//
//  Created by Alex Delin on 02/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

class PlayersController: UITableViewController, PickerAlertDelegate {

    var team : Team?
    var players : [Player]?
    var season = "2018-19"
    
    
    let spinner = UIActivityIndicatorView()
    var loadingView = UIView()
    var navBarTitleView : PlayersNavBarTitleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        
        
        if let navBar = self.navigationController?.navigationBar {
            
            navBarTitleView = PlayersNavBarTitleView(teamName: team?.fullName ?? "Roster", season: season)
            navBar.addSubview(navBarTitleView!)
            
            navBarTitleView!.translatesAutoresizingMaskIntoConstraints = false
            navBarTitleView!.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
            navBarTitleView!.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
            
            navBarTitleView?.seasonButton.addTarget(self, action: #selector(chooseSeason), for: .touchUpInside)
            
        }
        
        setLoadingScreen()
        getPlayers()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navBarTitleView?.isHidden = true
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
    
//    MARK: - PickerAlertDelegate
    func handlePickerValue(_ value: String) {
        if season != value {
            season = value
            if loadingView.isHidden == false {
                removeLoadingScreen()
            }
            setLoadingScreen()
            getPlayers()
            navBarTitleView?.seasonButton.setTitle(self.season + " ⩔", for: .normal)
        }
    }

    
//    MARK: - GET Methods
    fileprivate func getPlayers() {
        APIManager.sharedManager.getPlayersOfTeam(id: team!.id, season: season) { (players : [Player]) in
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
        let newLoadingView = UIView()
        newLoadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        newLoadingView.backgroundColor = UIColor.white
        
        spinner.style = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        spinner.center = newLoadingView.center
        
        newLoadingView.addSubview(spinner)
        tableView.addSubview(newLoadingView)
        
        tableView.isScrollEnabled = false
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
        
        loadingView = newLoadingView
        
    }
    
    fileprivate func removeLoadingScreen() {
        
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingView.isHidden = true
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        
    }
    
    @objc private func chooseSeason() {
        
        let pickerAlert = PickerAlertController(withTeam: team!, season: season)
        pickerAlert.delegate = self
        
        present(pickerAlert, animated: true, completion: nil)
        
    }
    
}
