//
//  MatchViewController.swift
//  FootballMenago
//
//  Created by Artur on 15/02/2021.
//

import UIKit

class PlayerMatchTabelViewCell: UITableViewCell{
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var playerNameText: UITextField!
    
    //    @IBOutlet weak var timeTextField: UILabel!
    //    @IBOutlet weak var goalsTextField: UILabel!
    //    @IBOutlet weak var assisstsTextField: UILabel!
    //    @IBOutlet weak var yellowCardTextField: UILabel!
    //    @IBOutlet weak var redCardTextField: UILabel!
    //    @IBOutlet weak var degreeTextField: UILabel!
    
    @IBOutlet weak var timeTextField: UILabel!
    @IBOutlet weak var goalsTextField: UILabel!
    @IBOutlet weak var assisstsTextField: UILabel!
    @IBOutlet weak var yellowCardTextField: UILabel!
    @IBOutlet weak var redCardTextField: UILabel!
    @IBOutlet weak var degreeTextField: UILabel!
    
}

class MatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var enemyNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var jsonGame: JsonClassGames?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonGame = JsonClassGames()
        
        self.tableView.allowsMultipleSelection = true
        
        enemyNameLabel.text = (jsonGame?.gamesObject?.games[Tmp.tmpGame].enemyTeam)!
        teamNameLabel.text = (jsonGame?.gamesObject?.games[Tmp.tmpGame].teamName)!
        dateLabel.text = String((jsonGame?.gamesObject?.games[Tmp.tmpGame].date)!)
        super.viewDidLoad()
        
        
    }
    
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
            rowCount = (jsonGame?.gamesObject?.games[Tmp.tmpGame].mainTeamSize)!
        }
        if section == 1 {
            rowCount = (jsonGame?.gamesObject?.games[Tmp.tmpGame].secondTeamSize)!
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerMatchTabelViewCell
        
        if indexPath.section == 0 {
            cell.numberTextField.text = jsonGame?.getNumber(game: Tmp.tmpGame, player: indexPath.row)
            cell.playerNameText.text = jsonGame?.getName(game: Tmp.tmpGame, player: indexPath.row)
            
            cell.timeTextField.text = jsonGame?.getPlayedTime(game: Tmp.tmpGame, player: indexPath.row)
            cell.goalsTextField.text = jsonGame?.getNumbersOfGoals(game: Tmp.tmpGame, player: indexPath.row)
            cell.assisstsTextField.text = jsonGame?.getAssists(game: Tmp.tmpGame, player: indexPath.row)
            cell.yellowCardTextField.text = jsonGame?.getNumbersOFYellowCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.redCardTextField.text = jsonGame?.get7NumbersOfRedCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.degreeTextField.text = jsonGame?.getGrade(game: Tmp.tmpGame, player: indexPath.row)
        }
        if indexPath.section == 1 {
            cell.numberTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][1]
            cell.playerNameText.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][0]
            cell.timeTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][9]
            cell.goalsTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][4]
            cell.assisstsTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][5]
            cell.yellowCardTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][6]
            cell.redCardTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][7]
            cell.degreeTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][8]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func goalButton(_ sender: Any) {
        
        
        
        
    }
}
