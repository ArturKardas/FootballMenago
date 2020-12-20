//
//  GameHistoryViewController.swift
//  FootballMenago
//
//  Created by Artur on 20/12/2020.
//

import UIKit

class GameHistoryViewController: UIViewController {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var jsonGame: JsonClassGames?
    
    override func viewDidLoad() {
        
        jsonGame = JsonClassGames()
        
        gameNameLabel.text = "          Nawa Meczu: " + (jsonGame?.gamesObject?.games[Variables.tmpGame].name)!
        teamNameLabel.text = "          Drużyna: " + (jsonGame?.gamesObject?.games[Variables.tmpGame].teamName)!
        ageLabel.text = "          Rocznik: " + String((jsonGame?.gamesObject?.games[Variables.tmpGame].age)!)
        super.viewDidLoad()

    }

}
