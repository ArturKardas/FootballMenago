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
    
    
    @IBOutlet weak var allyState: UITextField!
    @IBOutlet weak var enemyState: UITextField!
    @IBOutlet weak var minusEnemyButton: UIButton!
    
    @IBOutlet weak var tableV: UITableView!
    
    var selectRow1 = IndexPath()
    var selectRow2 = IndexPath()
    var select1 = false
    var select2 = false
    
    var jsonGame: JsonClassGames?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonGame = JsonClassGames()
        var game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        
        
        enemyNameLabel.text = (game?.enemyTeam)!
        teamNameLabel.text = (game?.teamName)!
        dateLabel.text = String((game?.date)!)
        hourLabel.text = game?.hour
        minusEnemyButton.isUserInteractionEnabled = false
        self.tableV.allowsMultipleSelection = true
        
        
        
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
            cell.SurnameTextField.text = jsonGame?.getSurname(game: Tmp.tmpGame, player: indexPath.row)
            
            cell.timeTextField.text = jsonGame?.getPlayedTime(game: Tmp.tmpGame, player: indexPath.row)
            cell.goalsTextField.text = jsonGame?.getNumbersOfGoals(game: Tmp.tmpGame, player: indexPath.row)
            cell.assisstsTextField.text = jsonGame?.getAssists(game: Tmp.tmpGame, player: indexPath.row)
            cell.yellowCardTextField.text = jsonGame?.getNumbersOFYellowCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.redCardTextField.text = jsonGame?.get7NumbersOfRedCards(game: Tmp.tmpGame, player: indexPath.row)
            cell.degreeTextField.text = jsonGame?.getGrade(game: Tmp.tmpGame, player: indexPath.row)
            Tmp.tmpFirstTeam[indexPath.row] = indexPath.row
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
            Tmp.tmpBenchTeam[indexPath.row] = indexPath.row
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
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
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
    
    @IBAction func goalButton(_ sender: Any) {
        // MARK: Funkcja odpowiedzialna za obsługę przyciska GOL i błędów
        
        if select2 == false && select1 == true && selectRow1.section == 0{
            let alert = UIAlertController(title: "GOOOOL", message: "Wpisz w której minucie strzelono gola, oraz kto asystował (opcjonalnie)", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].text = "Minuta"
            alert.textFields![0].isUserInteractionEnabled = false
            
            alert.addTextField()
            alert.textFields![1].keyboardType = UIKeyboardType.numberPad
            
            alert.addTextField()
            alert.textFields![2].text = "Numer Asystującego"
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
        var goals = Int(string!)
        goals = goals! + 1
        jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][4] = String(goals!)
        
        
        var assistPlayer = ""
        //asysta
        for i in 0 ..< game!.mainTeamSize {
            if game!.players[i][1] == asisst{
                var assist = Int((game?.players[i][5])!)
                assist = assist! + 1
                jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][5] = String("\(assist ?? 0)")
                assistPlayer = (jsonGame?.gamesObject?.games[Tmp.tmpGame].players[i][13])!
                
                let array = tableV.indexPathsForVisibleRows
                tableV.reloadRows(at:[array![i]], with: UITableView.RowAnimation.bottom)
            }
        }
        
        jsonGame?.gamesObject?.games[Tmp.tmpGame].goals.append(["\(val!+1)-"+enemyState.text! , minute + "'", player! , assistPlayer])
        jsonGame?.save()
        
        //tech
        select1 = false
        tableV.cellForRow(at: selectRow1)?.isSelected = false
        tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
        print("Goal")
    }
    
    @IBAction func yellowCardButton(_ sender: Any) {
        if select2 == false && select1 == true {
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
            
            print("Goals")
        }else {
            print("NIe można dodać gola bo za dużo zaznaczonych")
        }
        
    }
    
    
    @IBAction func redCardButton(_ sender: Any) {
        // MARK: Czerwona kartka
        if select2 == false && select1 == true{
            let alert = UIAlertController(title: "Czy chcesz dać zawodnikowi CZERWONĄ kartkę?", message: "Jeśli tak wpisz w której minucie meczu.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].keyboardType = UIKeyboardType.numberPad
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
        // MARK: zmiana zawodnika
        
        if select2 == true && selectRow2.section != selectRow1.section{
            let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz wymienić zawodników? Jeśli tak to wpisz w której minucie :D", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField()
            alert.textFields![0].keyboardType = UIKeyboardType.numberPad
            alert.textFields![0].placeholder = "24"
            
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
    
    @IBAction func addEnemy(_ sender: Any) {
        
        let alert = UIAlertController(title: "GOL", message: "Wpisz w której minucie przeciwnik strzelił bramkę.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField()
        alert.textFields![0].keyboardType = UIKeyboardType.numberPad
        alert.textFields![0].placeholder = "24"
        
        let tak = UIAlertAction(title: "GOL", style: .default, handler:{(action) -> Void in self.addEnemyGoalFunc(minute: alert.textFields![0].text!)})
        let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in print("nie dodano gola przeciwnikowi")})
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addEnemyGoalFunc(minute: String)  {
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
            minusEnemyButton.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func endGAmeButton(_ sender: Any) {
        
        // MARK: zakończenie gry
        let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz zakończyć mecz?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.endDD()})
        let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie zakończono meczu")})
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func redCard(minute: String) {
        let string = jsonGame?.get7NumbersOfRedCards(game: Tmp.tmpGame, player: selectRow1.row)
        var cards = Int(string!)
        cards = cards! + 1
        
        if selectRow1.section == 0 {
            if minute != ""{
                jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][9] = minute
            }
            
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row][7] = String(cards!)
            jsonGame?.save()
            
            tableV.cellForRow(at: selectRow1)?.isSelected = false
            tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
            tableV.cellForRow(at: selectRow1)?.backgroundColor = UIColor.red
            tableV.cellForRow(at: selectRow1)?.isUserInteractionEnabled = false
        }
        select1 = false
    }
    
    func switchFunc(minute: String) {
        
        // TODO: Żle działa sprawdzanie czy jedne jest zaxznaczony
        if select1 == true && select2 == true && selectRow2.section == 1 && selectRow2.section != selectRow1.section{
            var playerOut = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row]
            var playerIn = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow2.row]
            
            if minute != ""{
                playerOut![9] = minute
                playerIn![9] = minute
            }
            
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow1.row] = playerIn!
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow2.row] = playerOut!
            
            tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
            tableV.reloadRows(at: [selectRow2], with: UITableView.RowAnimation.bottom)
            
            select1 = false
            tableV.cellForRow(at: selectRow1)?.isSelected = false
            
            select2 = false
            tableV.cellForRow(at: selectRow2)?.isUserInteractionEnabled = false
            tableV.cellForRow(at: selectRow2)?.backgroundColor = UIColor.red
            tableV.cellForRow(at: selectRow2)?.isSelected = false
        }else if select1 == true && select2 == true && selectRow2.section == 0 && selectRow2.section != selectRow1.section{
            var playerOut = jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row]
            var playerIn = jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow2.row]
            
            if minute != ""{
                playerOut![9] = minute
                playerIn![9] = minute
            }
            
            jsonGame?.gamesObject?.games[Tmp.tmpGame].bench[selectRow1.row] = playerIn!
            jsonGame?.gamesObject?.games[Tmp.tmpGame].players[selectRow2.row] = playerOut!
            
            tableV.reloadRows(at: [selectRow1], with: UITableView.RowAnimation.bottom)
            tableV.reloadRows(at: [selectRow2], with: UITableView.RowAnimation.bottom)
            
            select1 = false
            tableV.cellForRow(at: selectRow1)?.isSelected = false
            tableV.cellForRow(at: selectRow1)?.isUserInteractionEnabled = false
            tableV.cellForRow(at: selectRow1)?.backgroundColor = UIColor.red
            
            select2 = false
            tableV.cellForRow(at: selectRow2)?.isSelected = false
        }
    }
    
    func endDD(){
        let size = (jsonGame?.getFirstTeamSize(game: Tmp.tmpGame))!
        var game = jsonGame?.gamesObject?.games[Tmp.tmpGame]
        // TODO: zsumowanie wszystkim minut
        for i in 0 ..< size {
            //sprawdzenie czy zawodnik otrzymał żółtą kartkę
            if game?.players[i][7] == "1" && game?.players[i][9] != ""{
                
            }else{
                var time = Int((game?.players[i][9])!)
                time = (game!.timeHalf*2) - time!
                game?.players[i][9] = String(time!)
            }
        }
        
        if game?.fullTimeAlly == 0 && game?.fullTimeEnemy == 0 && (game?.firstHalfAlly  != 0 || game?.firstHalfEnemy != 0 ){
            game?.fullTimeAlly = Int(allyState.text!)!
            game?.fullTimeEnemy = Int(enemyState.text!)!
        }
        
        jsonGame?.gamesObject?.games[Tmp.tmpGame] = game!
        jsonGame?.save()
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
}

