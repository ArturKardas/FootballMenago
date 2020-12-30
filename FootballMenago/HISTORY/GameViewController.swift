//
//  GameHistoryViewController.swift
//  FootballMenago
//
//  Created by Artur on 20/12/2020.
//

import UIKit

class PlayerHistoryTabelViewCell: UITableViewCell{
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var playerNameText: UITextField!
    
    
    @IBOutlet weak var timeTextField: UILabel!
    @IBOutlet weak var eightteenTextField: UILabel!
    @IBOutlet weak var sevenTedxtField: UILabel!
    @IBOutlet weak var goalsTextField: UILabel!
    @IBOutlet weak var assisstsTextField: UILabel!
    @IBOutlet weak var yellowCardTextField: UILabel!
    @IBOutlet weak var redCardTextField: UILabel!
    @IBOutlet weak var degreeTextField: UILabel!
    
}

class SectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionTextName: UITextField!
}

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var jsonGame: JsonClassGames?
    
    override func viewDidLoad() {
        
        jsonGame = JsonClassGames()
        
        gameNameLabel.text = (jsonGame?.gamesObject?.games[Variables.tmpGame].name)!
        teamNameLabel.text = (jsonGame?.gamesObject?.games[Variables.tmpGame].teamName)!
        ageLabel.text = String((jsonGame?.gamesObject?.games[Variables.tmpGame].age)!)
        dateLabel.text = String((jsonGame?.gamesObject?.games[Variables.tmpGame].date)!)
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
                rowCount = (jsonGame?.gamesObject?.games[Variables.tmpGame].mainTeamSize)!
            }
            if section == 1 {
                rowCount = (jsonGame?.gamesObject?.games[Variables.tmpGame].secondTeamSize)!
            }
            return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerHistoryTabelViewCell
        
        if indexPath.section == 0 {
            cell.numberTextField.text = jsonGame?.getNumber(game: Variables.tmpGame, player: indexPath.row)
            cell.playerNameText.text = jsonGame?.getName(game: Variables.tmpGame, player: indexPath.row)
            
            cell.timeTextField.text = jsonGame?.getPlayedTime(game: Variables.tmpGame, player: indexPath.row)
            cell.eightteenTextField.text = jsonGame?.get18(game: Variables.tmpGame, player: indexPath.row)
            cell.sevenTedxtField.text = jsonGame?.get7(game: Variables.tmpGame, player: indexPath.row)
            cell.goalsTextField.text = jsonGame?.getNumbersOfGoals(game: Variables.tmpGame, player: indexPath.row)
            cell.assisstsTextField.text = jsonGame?.getAssists(game: Variables.tmpGame, player: indexPath.row)
            cell.yellowCardTextField.text = jsonGame?.getNumbersOFYellowCards(game: Variables.tmpGame, player: indexPath.row)
            cell.redCardTextField.text = jsonGame?.get7NumbersOfRedCards(game: Variables.tmpGame, player: indexPath.row)
            cell.degreeTextField.text = jsonGame?.getGrade(game: Variables.tmpGame, player: indexPath.row)
        }
        if indexPath.section == 1 {
            cell.numberTextField.text = jsonGame?.getNumber(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.playerNameText.text = jsonGame?.getName(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.timeTextField.text = jsonGame?.getPlayedTime(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.eightteenTextField.text = jsonGame?.get18(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.sevenTedxtField.text = jsonGame?.get7(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.goalsTextField.text = jsonGame?.getNumbersOfGoals(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.assisstsTextField.text = jsonGame?.getAssists(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.yellowCardTextField.text = jsonGame?.getNumbersOFYellowCards(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.redCardTextField.text = jsonGame?.get7NumbersOfRedCards(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
            cell.degreeTextField.text = jsonGame?.getGrade(game: Variables.tmpGame, player: ((jsonGame?.getFirstTeamSize(game: Variables.tmpGame))!) + indexPath.row)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! SectionTableViewCell
        if section == 0 {
            header.sectionTextName.text = "Pierwszy Skład"
        }
        if section == 1 {
            header.sectionTextName.text = "Ławka rezerwowych"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
}


