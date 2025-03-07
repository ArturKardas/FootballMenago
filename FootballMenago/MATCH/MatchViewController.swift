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
    @IBOutlet weak var SurnameTextField: UITextField!
    
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
    @IBOutlet weak var hourLabel: UILabel!
    
    
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var allyState: UITextField!
    @IBOutlet weak var enemyState: UITextField!
    @IBOutlet weak var minusEnemyButton: UIButton!
    @IBOutlet weak var minusAllyButton: UIButton!
    
    //functionsButton
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    
    
    //Buttons and time text field
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var yellowCardButton: UIButton!
    @IBOutlet weak var redCardButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var opinionButton: UIButton!
    
    
    @IBOutlet weak var tableV: UITableView!
    
    //noteField
    @IBOutlet weak var noteField: UITextView!
    
    var selectRow1 = IndexPath()
    var selectRow2 = IndexPath()
    var select1 = false
    var select2 = false
    
    var jsonGame: JsonClassGames?
    
    
    //var i = 0
    var timer = Timer()
    
    //licznik połówek
    var numberOfHalf: Int = 1
    
    override func viewDidLoad() {
        
        
        jsonGame = JsonClassGames()
        let game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        Tmp.halfTime = 0
        
        breakButton.backgroundColor = UIColor.gray
        breakButton.isUserInteractionEnabled = false
        yellowCardButton.isUserInteractionEnabled = false
        redCardButton.isUserInteractionEnabled = false
        switchButton.isUserInteractionEnabled = false
        goalButton.isUserInteractionEnabled = false
        
        enemyNameLabel.text = (game?.enemyTeam)!
        teamNameLabel.text = (game?.teamName)!
        dateLabel.text = String((game?.date)!)
        hourLabel.text = game?.hour
        
        minusEnemyButton.isUserInteractionEnabled = false
        minusAllyButton.isUserInteractionEnabled = false
        self.tableV.allowsMultipleSelection = true
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func addMinuteToFirstTeam(){
        var players = jsonGame?.gamesObject?.games[Tmp.tmpGame].players
        //        let dateTo = Date()
        //        let diffComponents = Calendar.current.dateComponents([.minute], from: Tmp.startTime, to: dateTo)
        let minuteOfTheMatch = Int(timeTextField.text!)!
        
        for i in 0 ..< players!.count{
            if players![i][7] == "1"{
                
            }else{
                let m = Int(players![i][14])
                players![i][14] = String(minuteOfTheMatch)
                let timePlayed = Int(players![i][9])
                players![i][9] =  String(timePlayed! + minuteOfTheMatch - m!)
            }
            
        }
        jsonGame?.gamesObject?.games[Tmp.tmpGame].players = players!
        jsonGame?.save()
        
        if select1 == false{
            var array = tableV.indexPathsForVisibleRows
            array?.removeLast()
            print(array)
            tableV.reloadRows(at:array!, with: .none)
            select1 = false
            select2 = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pierwszy skład"
        }
        if section == 1 {
            return "Drugi skład"
        }
        if section == 2 {
            return "Notatka"
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
        
        
        // TODO: let players = jsonGame?.gamesObject?.games[Tmp.tmpGame].players
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerMatchTabelViewCell
            
            cell.numberTextField.text = jsonGame?.getNumber(game: Tmp.tmpGame, player: indexPath.row)
            cell.playerNameText.text = jsonGame?.getName(game: Tmp.tmpGame, player: indexPath.row)
            cell.SurnameTextField.text = jsonGame?.getSurname(game: Tmp.tmpGame, player: indexPath.row)
            
            cell.timeTextField.text = jsonGame?.getPlayedTime(game: Tmp.tmpGame, player: indexPath.row)
            cell.goalsTextField.text = jsonGame?.getNumbersOfGoals(game: Tmp.tmpGame, player: indexPath.row)
            cell.assisstsTextField.text = jsonGame?.getAssists(game: Tmp.tmpGame, player: indexPath.row)
            cell.yellowCardTextField.text = jsonGame?.getNumbersOFYellowCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.redCardTextField.text = jsonGame?.get7NumbersOfRedCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.degreeTextField.text = jsonGame?.getGrade(game: Tmp.tmpGame, player: indexPath.row)
            Tmp.tmpFirstTeam[indexPath.row] = indexPath.row
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerMatchTabelViewCell
            
            cell.numberTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][1]
            cell.playerNameText.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][0]
            cell.SurnameTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][13]
            cell.timeTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][9]
            cell.goalsTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][4]
            cell.assisstsTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][5]
            cell.yellowCardTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][6]
            cell.redCardTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][7]
            cell.degreeTextField.text = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[indexPath.row][8]
            Tmp.tmpBenchTeam[indexPath.row] = indexPath.row
            return cell
        }
        
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
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
        if section == 2{
            header.sectionTextName.text = "Notatki"
            header.labelsView.self.isHidden = true
        }
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1{
            return 35
        }else{
            return  1500
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 1{
            if select1 == false{
                selectRow1 = indexPath
                select1 = true
                print("to")
                print("------------")
                print("Zaznaczanie: \(selectRow1.row)+\(selectRow1.section)")
                print("Zaznaczanie: \(select2)")
            }else if select2 == false{
                selectRow2 = indexPath
                select2 = true
                print("po tym")
                print("------------")
                print("Zaznaczanie: \(selectRow1.row)+\(selectRow1.section)")
                print("Zaznaczanie: \(select2)")
                
            }else{
                print("za dużo zaznaczonych")
                tableView.cellForRow(at: indexPath)?.isSelected = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 1{
            if indexPath == selectRow1 && select1 == true{
                tableV.cellForRow(at: indexPath)?.isSelected = false
                if select2 == true{
                    selectRow1 = selectRow2
                    select2 = false
                    print("------------")
                    print("odznaczanie: \(selectRow1.row)+\(selectRow1.section)")
                    print("odznaczanie: \(select2)")
                }else{
                    select1 = false
                    print("------------")
                    print("odznaczanie: \(selectRow1.row)+\(selectRow1.section)")
                    print("odznaczanie: \(select2)")
                }
            }else if indexPath == selectRow2{
                select2 = false
                print("------------")
                print("odznaczanie: \(selectRow1.row)+\(selectRow1.section)")
                print("odznaczanie: \(select2)")
            }else{
                print("nie można odznaczyć takeigo wiersza")
            }
        }
    }
    
    @IBAction func goalButton(_ sender: Any) {
        // MARK: Funkcja odpowiedzialna za obsługę przyciska GOL i błędów
        if select2 == false && select1 == true && selectRow1.section == 0{
            let alert = UIAlertController(title: "GOOOOL", message: "Wpisz w której minucie strzelono gola, oraz kto asystował (opcjonalnie)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].text = "Minuta"
            alert.textFields![0].textAlignment = .center
            alert.textFields![0].isUserInteractionEnabled = false
            
            alert.addTextField()
            alert.textFields![1].text = timeTextField.text
            alert.textFields![1].keyboardType = UIKeyboardType.numberPad
            
            alert.addTextField()
            alert.textFields![2].text = "Numer Asystującego"
            alert.textFields![2].textAlignment = .center
            alert.textFields![2].isUserInteractionEnabled = false
            
            alert.addTextField()
            alert.textFields![3].keyboardType = UIKeyboardType.numberPad
            
            let tak = UIAlertAction(title: "GOOOOL", style: .default, handler:{(action) -> Void in self.goal(minute: alert.textFields![1].text!, asisst: alert.textFields![3].text!)})
            let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in print("nie dano kartki")})
            nie.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.addAction(tak)
            alert.addAction(nie)
            
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Uwaga", message: "Zaznacz poprawnie jednego zawodnika :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("Alert o błędzie zaznaczenia")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func goal(minute: String, asisst: String){
        // MARK: Funkcja odpowiedzialna za dodanie gola naszej drużynie
        
        let game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        //team
        let val = Int(allyState.text!)
        allyState.text = "\(val! + 1)"
        var minNew = minute
        if minute == "" {
            minNew = "0"
        }
        
        let min = Int(minNew)
        if min! < game!.timeHalf {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].firstHalfAlly = val! + 1
        }else{
            jsonGame?.gamesObject?.games[Tmp.tmpGame].fullTimeAlly = val! + 1
        }
        
        
        //player
        let string = jsonGame?.getNumbersOfGoals(game: Tmp.tmpGame, player: selectRow1.row)
        let player = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][13]
        let playerNumber = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][1]
        var goals = Int(string!)
        goals = goals! + 1
        jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][4] = String(goals!)
        
        
        var assistPlayer = ""
        var assistNumber = ""
        //asysta
        for i in 0 ..< game!.mainTeamSize {
            if game!.players[i][1] == asisst{
                var assist = Int((game?.players[i][5])!)
                assist = assist! + 1
                jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][5] = String("\(assist ?? 0)")
                assistPlayer = (jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][13])!
                assistNumber = (jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][1])!
                let array = tableV.indexPathsForVisibleRows
                tableV.reloadRows(at:[array![i]], with: UITableView.RowAnimation.bottom)
            }
        }
        
        jsonGame?.gamesObject?.games[Tmp.tmpGame].goals.append(["\(val!+1)-"+enemyState.text! , minute + "'", player! , assistPlayer, playerNumber!, assistNumber])
        jsonGame?.save()
        
        //tech
        minusAllyButton.isUserInteractionEnabled = true
        select1 = false
        tableV.cellForRow(at: selectRow1)?.isSelected = false
        tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
        
        //reload table
        let array = tableV.indexPathsForVisibleRows
        tableV.reloadRows(at:array!, with: .none)
        select1 = false
        select2 = false
        print("Goal")
    }
    
    @IBAction func yellowCardButton(_ sender: Any) {
        // MARK: Żółta kartka button
        if select2 == false && select1 == true && selectRow1.section == 0{
            let alert = UIAlertController(title: "Czy chcesz dać zawodnikowi Żółtą kartkę?", message: "Jeśli tak wpisz w której minucie meczu.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].keyboardType = UIKeyboardType.numberPad
            alert.textFields![0].text = timeTextField.text
            
            let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.yellowCard(minute: alert.textFields![0].text!)})
            let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie dano kartki")})
            nie.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.addAction(tak)
            alert.addAction(nie)
            
            self.present(alert, animated: true, completion: nil)
        }else if (select2 == true && select1 == true){
            let alert = UIAlertController(title: "Uwaga", message: "Za dużo zaznaczonych zawodników, odznacz proszę jednego :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Uwaga", message: "Zaznacz zawodnika z pierwszego składu :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func redCardButton(_ sender: Any) {
        // MARK: Czerwona kartka button
        if select2 == false && select1 == true  && selectRow1.section == 0{
            let alert = UIAlertController(title: "Czy chcesz dać zawodnikowi CZERWONĄ kartkę?", message: "Jeśli tak wpisz w której minucie meczu.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].keyboardType = UIKeyboardType.numberPad
            alert.textFields![0].text = timeTextField.text
            let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.redCard(minute: alert.textFields![0].text!)})
            let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie dano kartki")})
            nie.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.addAction(tak)
            alert.addAction(nie)
            
            self.present(alert, animated: true, completion: nil)
        }else if (select2 == true && select1 == true){
            let alert = UIAlertController(title: "Uwaga", message: "Za dużo zaznaczonych zawodników, odznacz proszę jednego :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Uwaga", message: "Zaznacz zawodnika :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func switchButton(_ sender: Any) {
        // MARK: zmiana zawodnika button
        
        if select2 == true && selectRow2.section != selectRow1.section{
            let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz wymienić zawodników? Jeśli tak to wpisz w której minucie :D", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].keyboardType = UIKeyboardType.numberPad
            alert.textFields![0].text = timeTextField.text
            
            let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.switchFunc(minute: alert.textFields![0].text!)})
            let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie dokończono zmiany")})
            nie.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.addAction(tak)
            alert.addAction(nie)
            
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Uwaga", message: "Zaznacz poprawnie dwóch zawodników :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("Alert o błędzie zaznaczenia")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func optionButton(_ sender: Any) {
        
        
        // MARK: Naciśniecie option
        if select2 == false && select1 == true{
            let alert = UIAlertController(title: "Ocena Zawodnika", message: "", preferredStyle: UIAlertController.Style.alert)
            
            var ocena = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][8]
            var uwaga = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][10]
            
            if selectRow1.section == 1{
                ocena = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row][8]
                uwaga = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row][10]
            }
            
            alert.addTextField()
            alert.textFields![0].text = "Ocena"
            alert.textFields![0].isUserInteractionEnabled = false
            alert.textFields![0].textAlignment = .center
            
            alert.addTextField()
            alert.textFields![1].text = ocena
            alert.textFields![1].keyboardType = UIKeyboardType.numberPad
            
            alert.addTextField()
            alert.textFields![2].text = "Uwagi"
            alert.textFields![2].isUserInteractionEnabled = false
            alert.textFields![2].textAlignment = .center
            
            alert.addTextField()
            alert.textFields![3].keyboardType = UIKeyboardType.asciiCapable
            alert.textFields![3].text = uwaga
            alert.textFields![3].frame.size.height = 60
            
            let tak = UIAlertAction(title: "OK", style: .default, handler:{(action) -> Void in self.optionFunc(grade: alert.textFields![1].text!, warnung: alert.textFields![3].text!)})
            let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in print("nie dano kartki")})
            nie.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.addAction(tak)
            alert.addAction(nie)
            
            self.present(alert, animated: true, completion: nil)
        }else if (select2 == true && select1 == true){
            let alert = UIAlertController(title: "Uwaga", message: "Za dużo zaznaczonych zawodników, odznacz proszę jednego :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Uwaga", message: "Zaznacz zawodnika z pierwszego składu :)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func optionFunc(grade: String, warnung: String) {
        if selectRow1.section == 0 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][8] = grade
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][10] = warnung
        }else if selectRow1.section == 1 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row][8] = grade
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row][10] = warnung
        }
        
        jsonGame?.save()
        tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
        
        select1 = false
        tableV.cellForRow(at: selectRow1)?.isSelected = false
        
        //reload table
        let array = tableV.indexPathsForVisibleRows
        tableV.reloadRows(at:array!, with: .none)
        select1 = false
        select2 = false
    }
    
    
    @IBAction func addEnemy(_ sender: Any) {
        // MARK: Gol dla przeciwnika button
        let alert = UIAlertController(title: "GOL", message: "Wpisz w której minucie przeciwnik strzelił bramkę.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField()
        alert.textFields![0].keyboardType = UIKeyboardType.numberPad
        alert.textFields![0].text = timeTextField.text
        
        let tak = UIAlertAction(title: "GOL", style: .default, handler:{(action) -> Void in self.addEnemyGoalFunc(minute: alert.textFields![0].text!)})
        let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in print("nie dodano gola przeciwnikowi")})
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addEnemyGoalFunc(minute: String)  {
        // MARK: Funkcja obsługująca gola przeciwnika
        var goals = Int(enemyState.text!)
        goals = goals! + 1
        enemyState.text = String(goals!)
        
        let minInt = Int(minute)
        
        if minInt! <= 45 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].firstHalfEnemy = goals!
        }else if minInt! > 45 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].fullTimeEnemy = goals!
        }else{
            jsonGame?.gamesObject?.games[Tmp.tmpGame].fullTimeEnemy = goals!
        }
        
        jsonGame?.gamesObject?.games[Tmp.tmpGame].goals.append([allyState.text!+"-"+enemyState.text! , minute + "'", "przeciwnik", ""])
        
        jsonGame?.save()
        minusEnemyButton.isUserInteractionEnabled = true
    }
    
    @IBAction func minusEnemy(_ sender: Any) {
        // MARK: Odejmowanie gola przeciwnikowi
        var goals = Int(enemyState.text!)
        let game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        let first = Int(game!.firstHalfEnemy)
        
        
        if goals == first {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].firstHalfEnemy = goals! - 1
        }else{
            jsonGame?.gamesObject?.games[Tmp.tmpGame].fullTimeEnemy = goals! - 1
        }
        
        goals = goals! - 1
        enemyState.text = String(goals!)
        if goals! < 1 {
            minusAllyButton.isUserInteractionEnabled = false
        }
        
        var max = (game?.goals.count)! - 1
        var bool: Bool = false
        
        while bool == false && max >= 0{
            if game?.goals[max][2] == "przeciwnik"{
                jsonGame?.gamesObject?.games[Tmp.tmpGame].goals.remove(at: max)
                jsonGame?.save()
                bool = true
            }
            max = max - 1
        }
        
    }
    
    @IBAction func minusGoalAlly(_ sender: Any) {
        // MARK: Odejmowanie gola swoim :D
        var goals = Int(allyState.text!)
        let game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        let first = Int(game!.firstHalfAlly)
        
        
        if goals == first {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].firstHalfAlly = goals! - 1
        }else{
            jsonGame?.gamesObject?.games[Tmp.tmpGame].fullTimeAlly = goals! - 1
        }
        
        goals = goals! - 1
        allyState.text = String(goals!)
        if goals! < 1 {
            minusAllyButton.isUserInteractionEnabled = false
        }
        
        var max = (game?.goals.count)! - 1
        var bool: Bool = false
        
        var numberGoal: String
        var numberAssist: String
        
        
        while bool == false && max >= 0{
            if game?.goals[max][2] != "przeciwnik"{
                numberGoal = (game?.goals[max][4])!
                numberAssist = (game?.goals[max][5])!
                
                for i in 0 ..< (game?.players.count)!{
                    if game?.players[i][1] == numberGoal{
                        let goal = Int((jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][4])!)
                        jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][4] = "\(goal! - 1)"
                        let array = tableV.indexPathsForVisibleRows
                        tableV.reloadRows(at:[array![i]], with: UITableView.RowAnimation.bottom)
                    }
                    if game?.players[i][1] == numberAssist{
                        let asis = Int((jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][5])!)
                        jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][5] = "\(asis! - 1)"
                        let array = tableV.indexPathsForVisibleRows
                        tableV.reloadRows(at:[array![i]], with: UITableView.RowAnimation.bottom)
                    }
                }
                
                for i in 0 ..< (game?.bench.count)!{
                    if game?.bench[i][1] == numberGoal{
                        let goal = Int((jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[i][4])!)
                        jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[i][4] = "\(goal! - 1)"
                        let array = tableV.indexPathsForVisibleRows
                        let index = game?.mainTeamSize
                        tableV.reloadRows(at:[array![index! + i]], with: UITableView.RowAnimation.bottom)
                        
                    }
                    if game?.bench[i][1] == numberAssist{
                        let asis = Int((jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[i][5])!)
                        jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[i][5] = "\(asis! - 1)"
                        let array = tableV.indexPathsForVisibleRows
                        let index = game?.mainTeamSize
                        tableV.reloadRows(at:[array![index! + i]], with: UITableView.RowAnimation.bottom)
                    }
                }
                
                jsonGame?.gamesObject?.games[Tmp.tmpGame].goals.remove(at: max)
                
                jsonGame?.save()
                bool = true
            }
            max = max - 1
        }
        
        
    }
    
    @IBAction func playerNoteButtonClicked(_ sender: Any) {
        // MARK: Naciśnięcie przycisku Player Enemy
        
        let note: String
        if (jsonGame?.gamesObject?.games[Tmp.tmpGame].other.count)! < 2{
            note = ""
            jsonGame?.gamesObject?.games[Tmp.tmpGame].other.append("")
        }else{
            note = (jsonGame?.gamesObject?.games[Tmp.tmpGame].other[1])!
        }
        let alertController = UIAlertController(title: "Notatka\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0.6, constant: 250)
        
        alertController.view.addConstraint(height)
        
        let margin:CGFloat = 8.0
        let rect = CGRect(x: margin, y: 50, width: 250 , height: 150)
        let customView = UITextView(frame: rect)
        
        customView.text = note
        
        alertController.view.addSubview(customView)
        
        let somethingAction = UIAlertAction(title: "Zapisz", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.playerNoteFunc(note: customView.text)
        })
        
        let cancelAction = UIAlertAction(title: "Anuluj", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func playerNoteFunc(note: String) {
        jsonGame?.gamesObject?.games[Tmp.tmpGame].other[1] = note
        jsonGame?.save()
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        Tmp.startTime = Date()
        
        startButton.backgroundColor = UIColor.gray
        startButton.isUserInteractionEnabled = false
        
        yellowCardButton.isUserInteractionEnabled = true
        redCardButton.isUserInteractionEnabled = true
        switchButton.isUserInteractionEnabled = true
        goalButton.isUserInteractionEnabled = true
        
        if numberOfHalf == Tmp.numberOfhalf{
            breakButton.isUserInteractionEnabled = false
            breakButton.backgroundColor = UIColor.gray
        }else{
            breakButton.isUserInteractionEnabled = true
            breakButton.backgroundColor = UIColor.blue
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.2 , repeats: true) { [self] (Timer) in
            let dateTo = Date()
            let diffComponents  = Calendar.current.dateComponents([ .minute, .second], from: Tmp.startTime, to: dateTo)
            let second = diffComponents.second
            let minuteOfTheMatch = diffComponents.minute!
            
            timeTextField.text = String(minuteOfTheMatch + Tmp.halfTime)
            secondTextField.text = String(format: "%02d", second!)
            self.addMinuteToFirstTeam()
        }
    }
    
    @IBAction func breakButtonClicked(_ sender: Any) {
        timer.invalidate()
        
        Tmp.halfTime = Int((jsonGame?.gamesObject?.games[Tmp.tmpGame].timeHalf)!) * numberOfHalf
        numberOfHalf = numberOfHalf + 1
        
        startButton.backgroundColor = UIColor.systemGreen
        startButton.isUserInteractionEnabled = true
        
        breakButton.isUserInteractionEnabled = false
        breakButton.backgroundColor = UIColor.gray
        
        var players = jsonGame?.gamesObject?.games[Tmp.tmpGame].players
        for i in 0 ..< players!.count{
            players![i][14] = String(Tmp.halfTime)
        }
        jsonGame?.gamesObject?.games[Tmp.tmpGame].players = players!
        jsonGame?.save()
    }
    
    @IBAction func endGameButtonClicked(_ sender: Any) {
        // MARK: zakończenie gry przycisk
        let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz zakończyć mecz?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.endDD()})
        let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie zakończono meczu")})
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func redCard(minute: String) {
        // MARK: czewrwona kartka funkcja
        let string = jsonGame?.get7NumbersOfRedCards(game: Tmp.tmpGame, player: selectRow1.row)
        var cards = Int(string!)
        cards = cards! + 1
        
        if selectRow1.section == 0 {
            //            if minute != ""{
            //                jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][9] = minute
            //            }
            
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][7] = String(cards!)
            jsonGame?.save()
            
            tableV.cellForRow(at: selectRow1)?.isSelected = false
            tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
            //            tableV.cellForRow(at: selectRow1)?.backgroundColor = UIColor.red
            //            tableV.cellForRow(at: selectRow1)?.isUserInteractionEnabled = false
        }
        select1 = false
        
        //reload table
        let array = tableV.indexPathsForVisibleRows
        tableV.reloadRows(at:array!, with: .none)
        select1 = false
        select2 = false
    }
    
    func yellowCard(minute: String){
        // MARK: żółta kartka funkcja
        let string = jsonGame?.getNumbersOFYellowCards(game: Tmp.tmpGame, player: selectRow1.row)
        var cards = Int(string!)
        cards = cards! + 1
        
        if selectRow1.section == 0 {
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][6] = String(cards!)
            jsonGame?.save()
        }
        
        select1 = false
        tableV.cellForRow(at: selectRow1)?.isSelected = false
        tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
        
        print("yellow")
        
        //reload table
        let array = tableV.indexPathsForVisibleRows
        tableV.reloadRows(at:array!, with: .none)
        select1 = false
        select2 = false
    }
    
    func switchFunc(minute: String) {
        // MARK: Funkcja obsługująca zmianę zawodników
        if select1 == true && select2 == true && selectRow2.section == 1 && selectRow2.section != selectRow1.section{
            let playerOut = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row]
            var playerIn = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow2.row]
            
            //playerIn![14] = minute
            if minute == ""{
                playerIn![14] = timeTextField.text!
            }
            playerIn![14] = timeTextField.text!
            
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row] = playerIn!
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow2.row] = playerOut!
            jsonGame?.save()
            
            
            tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
            tableV.reloadRows(at: [selectRow2], with: UITableView.RowAnimation.bottom)
            
            select1 = false
            tableV.cellForRow(at: selectRow1)?.isSelected = false
            
            select2 = false
            tableV.cellForRow(at: selectRow2)?.isSelected = false
        }else if select1 == true && select2 == true && selectRow2.section == 0 && selectRow2.section != selectRow1.section{
            var playerIn = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row]
            let playerOut = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow2.row]
            
            playerIn![14] = minute
            if minute == ""{
                playerIn![14] = timeTextField.text!
            }
            playerIn![14] = timeTextField.text!
            
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row] = playerOut!
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow2.row] = playerIn!
            jsonGame?.save()
            
            tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
            tableV.reloadRows(at: [selectRow2], with: UITableView.RowAnimation.bottom)
            
            select1 = false
            tableV.cellForRow(at: selectRow1)?.isSelected = false
            
            select2 = false
            tableV.cellForRow(at: selectRow2)?.isSelected = false
        }
        //reload table
        let array = tableV.indexPathsForVisibleRows
        tableV.reloadRows(at:array!, with: .none)
        select1 = false
        select2 = false
    }
    
    func endDD(){
        // MARK: Funkcja obsługująca zakończenie meczu
        var game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        timer.invalidate()
        
        if game?.fullTimeAlly == 0 && game?.firstHalfAlly  != 0 {
            game?.fullTimeAlly = Int(allyState.text!)!
        }
        
        if game?.fullTimeEnemy == 0 && game?.firstHalfEnemy != 0 {
            game?.fullTimeEnemy = Int(enemyState.text!)!
        }
        
        // zapisywanie szybkiej notatki
        let index = IndexPath(row: 0, section: 2)
        let cell: NoteCell = tableV.cellForRow(at: index) as! NoteCell
        
        jsonGame?.gamesObject?.games[Tmp.tmpGame].fastNote = cell.fastNoteTextView.text
        jsonGame?.save()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
}

