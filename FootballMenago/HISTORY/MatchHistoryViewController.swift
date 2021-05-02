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
    
    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBOutlet weak var timeTextField: UILabel!
    @IBOutlet weak var goalsTextField: UILabel!
    @IBOutlet weak var assisstsTextField: UILabel!
    @IBOutlet weak var yellowCardTextField: UILabel!
    @IBOutlet weak var redCardTextField: UILabel!
    @IBOutlet weak var degreeTextField: UILabel!
    
}

class SectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionTextName: UITextField!
    @IBOutlet weak var labelsView: UIStackView!
}

class NoteCell: UITableViewCell{
    
    @IBOutlet weak var fastNoteTextView: UITextView!
}

class MatchHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var enemyNameLabel: UILabel!
    @IBOutlet weak var enemyState: UITextField!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var allyState: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var table: UITableView!
    var jsonGame: JsonClassGames?
    
    override func viewDidLoad() {
        
        jsonGame = JsonClassGames()
        let game  = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        enemyNameLabel.text = (game?.enemyTeam)!
        teamNameLabel.text = (game?.teamName)!
        dateLabel.text = String((game?.date)!)
        hourLabel.text = game?.hour
        
        allyState.text = String(game!.fullTimeAlly)
        enemyState.text = String(game!.fullTimeEnemy)
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    //tableView
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pierwszy skład"
        }
        if section == 1 {
            return "Drugi skład"
        }
        if section == 2{
            return "Notatki"
        }
        return "Error"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = (jsonGame?.gamesObject?.games[Tmp.tmpGame].mainTeamSize)!
        }
        if section == 1 {
            rowCount = (jsonGame?.gamesObject?.games[Tmp.tmpGame].secondTeamSize)!
        }
        if section == 2 {
            return 1
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerHistoryTabelViewCell
            cell.numberTextField.text = jsonGame?.getNumber(game: Tmp.tmpGame, player: indexPath.row)
            cell.playerNameText.text = jsonGame?.getName(game: Tmp.tmpGame, player: indexPath.row)
            cell.surnameLabel.text = jsonGame?.getSurname(game: Tmp.tmpGame, player: indexPath.row)
            cell.timeTextField.text = jsonGame?.getPlayedTime(game: Tmp.tmpGame, player: indexPath.row)
            cell.goalsTextField.text = jsonGame?.getNumbersOfGoals(game: Tmp.tmpGame, player: indexPath.row)
            cell.assisstsTextField.text = jsonGame?.getAssists(game: Tmp.tmpGame, player: indexPath.row)
            cell.yellowCardTextField.text = jsonGame?.getNumbersOFYellowCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.redCardTextField.text = jsonGame?.get7NumbersOfRedCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.degreeTextField.text = jsonGame?.getGrade(game: Tmp.tmpGame, player: indexPath.row)
            cell.isUserInteractionEnabled = true
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerHistoryTabelViewCell
            cell.numberTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][1]
            cell.playerNameText.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][0]
            cell.surnameLabel.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][13]
            cell.timeTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][9]
            cell.goalsTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][4]
            cell.assisstsTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][5]
            cell.yellowCardTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][6]
            cell.redCardTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][7]
            cell.degreeTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][8]
            cell.isUserInteractionEnabled = true
            return cell
        }
        
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
            cell.fastNoteTextView.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].fastNote
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! NoteCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: Naciśniecie option
        if indexPath.section == 0 || indexPath.section == 1{
            let alert = UIAlertController(title: "Ocena Zawodnika", message: "", preferredStyle: UIAlertController.Style.alert)
            
            let game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
            var player:[String]
            
            if indexPath.section == 0 {
                player = (game?.players[indexPath.row])!
            }else{
                player = (game?.bench[indexPath.row])!
            }
            
            alert.addTextField()
            alert.textFields![0].text = "Ocena"
            alert.textFields![0].isUserInteractionEnabled = false
            alert.textFields![0].textAlignment = .center
            
            alert.addTextField()
            alert.textFields![1].text = player[8]
            alert.textFields![1].keyboardType = UIKeyboardType.numberPad
            
            alert.addTextField()
            alert.textFields![2].text = "Uwagi"
            alert.textFields![2].isUserInteractionEnabled = false
            alert.textFields![2].textAlignment = .center
            
            alert.addTextField()
            alert.textFields![3].keyboardType = UIKeyboardType.asciiCapable
            alert.textFields![3].text = player[10]
            alert.textFields![3].frame.size.height = 60
            
            let tak = UIAlertAction(title: "Zapisz", style: .default, handler:{(action) -> Void in self.optionFunc(grade: alert.textFields![1].text!, warnung: alert.textFields![3].text!, indexPath: indexPath)})
            let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in print("Anuluj")})
            nie.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.addAction(tak)
            alert.addAction(nie)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func optionFunc(grade: String, warnung: String, indexPath: IndexPath) {
        if indexPath.section == 0 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[indexPath.row][8] = grade
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[indexPath.row][10] = warnung
            jsonGame?.save()
        }else if indexPath.section == 1 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][8] = grade
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][10] = warnung
            jsonGame?.save()
        }
        
        table.beginUpdates()
        table.reloadRows(at: [indexPath], with: UITableView.RowAnimation.right)
        table.endUpdates()
        
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! SectionTableViewCell
        if section == 0 {
            header.sectionTextName.text = "Pierwszy Skład"
        }
        if section == 1 {
            header.sectionTextName.text = "Ławka rezerwowych"
        }
        if section == 2{
            header.sectionTextName.text = "Notatki"
            header.labelsView.self.isHidden = true
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1{
            return 40
        }else{
            return 1000
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    @IBAction func excelButtonClicked(_ sender: Any) {
        let excel = ExcelController()
        
        excel.printExcel()
        
        // create the alert
        let alert = UIAlertController(title: "Excel!!!", message: "Excel został stworzony w folderze PLIKI/FOOTBALLMENAGO", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteMatchClicked(_ sender: Any) {
        
        // MARK: zakończenie gry przycisk
        let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz usunąć mecz?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.deleteMatch()})
        let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie usunięto meczu")})
        tak.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func deleteMatch() {
        jsonGame?.gamesObject?.games.remove(at: Tmp.tmpGame)
        jsonGame?.save()
        
        Tmp.isCreated = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "teamsHistoryView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
    
}


