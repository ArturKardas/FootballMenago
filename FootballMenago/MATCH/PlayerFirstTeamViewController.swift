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
    let jsonGame = JsonClassGames()
    
    var selected: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonTeams.teamsObject?.teams[Tmp.tmpTeam].names.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerMatchCell") as! PlayerMatchCell
        
        cell.numberText.text = jsonTeams.getNumber(team: Tmp.tmpTeam, player: indexPath.row)
        cell.positionTextField.text = jsonTeams.getPosition(team: Tmp.tmpTeam, player: indexPath.row)
        cell.nameText.text = jsonTeams.getName(team: Tmp.tmpTeam, player: indexPath.row)
        cell.surnameTextField.text = jsonTeams.getSurname(team: Tmp.tmpTeam, player: indexPath.row)
        cell.birthDateTextField.text = jsonTeams.getDateOfBirthString(team: Tmp.tmpTeam, player: indexPath.row)
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
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        let index: Int = selected.count
        
        if index < (jsonGame.gamesObject?.games[Tmp.tmpGame].mainTeamSize)!{
            // create the alert
            let alert = UIAlertController(title: "Uwaga!", message: "Wybrałeś zbyt małą liczbę zawodników.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else if index > (jsonGame.gamesObject?.games[Tmp.tmpGame].mainTeamSize)!{
            // create the alert
            let alert = UIAlertController(title: "Uwaga!", message: "Wybrałeś zbyt wielu zawodników.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            for i in 0..<index {
                jsonGame.addPlayerToMainTeam(name: jsonTeams.getName(team: Tmp.tmpTeam, player: selected[i]), number: jsonTeams.getNumber(team: Tmp.tmpTeam, player: selected[i]), position: jsonTeams.getPosition(team: Tmp.tmpTeam, player: selected[i]), surname: jsonTeams.getSurname(team: Tmp.tmpTeam, player: selected[i]))
            }
            jsonGame.save()
            
            Tmp.tmpFirstTeam = selected
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BenchTeam")
            self.addChild(nextViewController)
            nextViewController.view.frame = self.view.frame
            self.view.addSubview(nextViewController.view)
        }
        
        
    }
    
}
