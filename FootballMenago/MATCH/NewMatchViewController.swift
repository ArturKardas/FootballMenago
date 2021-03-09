//
//  MatchViewController.swift
//  FootballMenago
//
//  Created by Artur on 16/10/2020.
//

import UIKit

class NewMatchViewController: UIViewController {

    var jsonGame: JsonClassGames!
    var jsonTeam: JsonClassTeams!
    
    //TextView
    @IBOutlet weak var hourOfMatch: UITextField!
    @IBOutlet weak var enemyTF: UITextField!
    @IBOutlet weak var teamSizeTF: UITextField!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!
    @IBOutlet weak var timeHalfTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Meczyk")
        
        jsonGame = JsonClassGames()
        jsonTeam = JsonClassTeams()
        
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        if day < 10 && month < 10{
            dataTF.text = String("0\(day)-0\(month)-\(year)")
        }else if day < 10 && month >= 10{
            dataTF.text = String("0\(day)-\(month)-\(year)")
        }else if day >= 10 && month < 10{
            dataTF.text = String("\(day)-0\(month)-\(year)")
        }else{
            dataTF.text = String("\(day)-\(month)-\(year)")
        }
        
        hourOfMatch.text = String("\(hour):\(minute)")
        
    }


    @IBAction func nextButtonClicked(_ sender: Any) {
        
       
        
        let enemyText = enemyTF.text!
        let teamSizeInt = Int(teamSizeTF.text!)!
        let dataText = dataTF.text!
        let hourText = hourOfMatch.text!
        let categoryText = categoryTF.text!
        let allyName = jsonTeam.teamsObject?.teams[Tmp.tmpTeam].title
        let age = jsonTeam.teamsObject?.teams[Tmp.tmpTeam].age
        let place = placeTF.text!
        let timeHalf = Int(timeHalfTF.text!)
        
        if teamSizeInt > (jsonTeam.teamsObject?.teams[Tmp.tmpTeam].numbers.count)!{
            let alert = UIAlertController(title: "UWAGA", message: "Masz za mało graczy w zaespole!", preferredStyle: UIAlertController.Style.alert)
            
            let tak = UIAlertAction(title: "OK", style: .default, handler:{(action) -> Void in print("alert")})
            
            alert.addAction(tak)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            jsonGame.addGame(teamName: allyName!, enemy: enemyText, teamSize: teamSizeInt, data: dataText, category: categoryText, age: age!, hour: hourText, place: place, timeHalf: timeHalf!)
            
            jsonGame.save()
            
            Tmp.tmpGame = (jsonGame.gamesObject?.games.count)! - 1
        }
        
        
        
 
    }
    
}
