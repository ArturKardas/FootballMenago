//
//  PlayerFirstTeamViewController.swift
//  FootballMenago
//
//  Created by Artur on 31/01/2021.
//

import UIKit

class PlayerMatchCell: UITableViewCell {
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var surnameTextField: UILabel!
    @IBOutlet weak var positionTextField: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var birthDateTextField: UILabel!
    
}

class PlayerFirstTeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    let jsonTeams = JsonClassTeams()
    
    var selected: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonTeams.teamsObject?.teams[Variables.tmpTeam].names.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerMatchCell") as! PlayerMatchCell
        
        cell.numberText.text = jsonTeams.getNumber(team: Variables.tmpTeam, player: indexPath.row)
        cell.positionTextField.text = jsonTeams.getPosition(team: Variables.tmpTeam, player: indexPath.row)
        cell.nameText.text = jsonTeams.getName(team: Variables.tmpTeam, player: indexPath.row)
        cell.surnameTextField.text = jsonTeams.getSurname(team: Variables.tmpTeam, player: indexPath.row)
        cell.birthDateTextField.text = jsonTeams.getDateOfBirthString(team: Variables.tmpTeam, player: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerPlayerMatchCell")
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected.append(indexPath.row)
        
        print(selected)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let i = selected.firstIndex(of: indexPath.row)
        selected.remove(at: i!)
        
        print(selected)
    }
    

}
