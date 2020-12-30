//
//  GameHistoryViewController.swift
//  FootballMenago
//
//  Created by Artur on 20/12/2020.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var jsonGame: JsonClassGames?
    
    override func viewDidLoad() {
        
        jsonGame = JsonClassGames()
        
        gameNameLabel.text = "          Nawa Meczu: " + (jsonGame?.gamesObject?.games[Variables.tmpGame].name)!
        teamNameLabel.text = "          Drużyna: " + (jsonGame?.gamesObject?.games[Variables.tmpGame].teamName)!
        ageLabel.text = "          Rocznik: " + String((jsonGame?.gamesObject?.games[Variables.tmpGame].age)!)
        dateLabel.text = "          Data: " + String((jsonGame?.gamesObject?.games[Variables.tmpGame].date)!)
        super.viewDidLoad()

    }
    
    //tableView
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pierwszy skład"
        }
        if section == 1 {
            return "Drugi skład"
        }
        return "Error"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
            if section == 0 {
                rowCount = 4
            }
            if section == 1 {
                rowCount = 0
            }
            return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: <#T##IndexPath#>)
        cell.backgroundColor = UIColor.secondaryLabel
        cell.textLabel?.text = (jsonGame?.gamesObject?.games[indexPath.section].players[indexPath.row])!
            + "  " + String((jsonGame?.gamesObject?.games[indexPath.section].numbers[indexPath.row])!)
            + "  " + String((jsonGame?.gamesObject?.games[indexPath.section].goals[indexPath.row])!)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        
        return cell
    }

}
