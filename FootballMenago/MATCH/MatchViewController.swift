//
//  MatchViewController.swift
//  FootballMenago
//
//  Created by Artur on 16/10/2020.
//

import UIKit

class MatchViewController: UIViewController {

    var jsonGame: JsonClassGames!
    var jsonTeam: JsonClassTeams!
    
    //TextView
    @IBOutlet weak var nameOfTeamsTF: UITextField!
    @IBOutlet weak var enemyTF: UITextField!
    @IBOutlet weak var teamSizeTF: UITextField!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Meczyk")
        
        jsonGame = JsonClassGames()
        jsonTeam = JsonClassTeams()
        
        
    }

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        let name = nameOfTeamsTF.text!
        let enemyText = enemyTF.text!
        let teamSizeInt = Int(teamSizeTF.text!)!
        let dataText = dataTF.text!
        let categoryText = categoryTF.text!
        let allyName = jsonTeam.teamsObject?.teams[Tmp.tmpTeam].title
        let age = jsonTeam.teamsObject?.teams[Tmp.tmpTeam].age
        
        jsonGame.addGame(teamName: allyName!, nameOfTeams: name, enemy: enemyText, teamSize: teamSizeInt, data: dataText, category: categoryText, age: age!)
        jsonGame.save()
        
        Tmp.tmpGame = (jsonGame.gamesObject?.games.count)! - 1
    }
    
}
