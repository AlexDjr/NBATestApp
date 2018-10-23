//
//  PickerAlertController.swift
//  NBATestApp
//
//  Created by Alex Delin on 15/10/2018.
//  Copyright © 2018 Alex Delin. All rights reserved.
//

import UIKit

protocol PickerAlertDelegate {
    func handlePickerValue(_ value: String)
}

class PickerAlertController: UIAlertController {
    
    var team : Team?
    var season : String?
    var delegate : PickerAlertDelegate?
    
    convenience init(withTeam team: Team, season: String) {
        self.init(title: nil, message: nil, preferredStyle: .actionSheet)
        setup(withTeam: team, season: season)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setup(withTeam team: Team, season: String) {
        self.team = team
        title = "CHOOSE NBA SEASON"
        message = "\n\n\n\n\n\n\n\n\n\n\n"
        
        let pickerView = UIPickerView(frame:CGRect.zero)
        pickerView.dataSource = self
        pickerView.delegate = self
        
        view.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
        
        pickerView.selectRow(team.seasons.index(of: season)!, inComponent: 0, animated: false)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.delegate?.handlePickerValue(team.seasons[pickerView.selectedRow(inComponent: 0)])
            }
        addAction(okAction)
        }
    
    }
    
    
extension PickerAlertController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    //    MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  team!.seasons.count
    }
    
    
    //    MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return team!.seasons[row]
    }


}
