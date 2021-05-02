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
    @IBOutlet weak var numberOfHalfTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print("Meczyk")
        
        jsonGame = JsonClassGames()
        jsonTeam = JsonClassTeams()
        
        if Tmp.isCreated == false{
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let day = calendar.component(.day, from: date)
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            
            dataTF.text = String(format: "%02d", day) + "." + String(format: "%02d", month) + "." + String(format: "%04d", year)
            
            hourOfMatch.text = String(format: "%02d", hour) + ":" + String(format: "%02d", minute)
            
        }else{
            let game = jsonGame.gamesObject?.games[Tmp.tmpGame]
            hourOfMatch.text = game?.hour
            enemyTF.text = game?.enemyTeam
            teamSizeTF.text = String(game!.mainTeamSize)
            dataTF.text = game?.date
            categoryTF.text = game?.typeOfMatch
            placeTF.text = game?.place
            timeHalfTF.text = String(game!.timeHalf)
            
        }
        
        
    }

    

    @IBAction func nextButtonClicked(_ sender: Any) {
        
        Tmp.numberOfhalf = Int(numberOfHalfTF.text!)!
        
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
            let alert = UIAlertController(title: "UWAGA", message: "Masz za mało graczy w zespole!", preferredStyle: UIAlertController.Style.alert)
            
            let tak = UIAlertAction(title: "OK", style: .default, handler:{(action) -> Void in print("alert")})
            
            alert.addAction(tak)
            
            self.present(alert, animated: true, completion: nil)
        }else if timeHalfTF.text == ""{
            let alert = UIAlertController(title: "UWAGA", message: "Prosze wpisz poprawnie standardowy czas jednej połowy", preferredStyle: UIAlertController.Style.alert)
            
            let tak = UIAlertAction(title: "OK", style: .default, handler:{(action) -> Void in print("alert")})
            
            alert.addAction(tak)
            
            self.present(alert, animated: true, completion: nil)
        }else{
            if Tmp.isCreated == true{
                var game = jsonGame.gamesObject?.games[Tmp.tmpGame]
                game?.hour = hourOfMatch.text!
                game?.enemyTeam = enemyTF.text!
                game?.mainTeamSize = Int(teamSizeTF.text!)!
                game?.date = dataTF.text!
                game?.typeOfMatch = categoryTF.text!
                game?.place = placeTF.text!
                game?.timeHalf = Int(timeHalfTF.text!)!
                jsonGame.gamesObject?.games[Tmp.tmpGame] = game!
                jsonGame.save()
            
            }else{
                jsonGame.addGame(teamName: allyName!, enemy: enemyText, teamSize: teamSizeInt, data: dataText, category: categoryText, age: age!, hour: hourText, place: place, timeHalf: timeHalf!)
                
                jsonGame.save()
                
                Tmp.tmpGame = (jsonGame.gamesObject?.games.count)! - 1
            }
        }
        
        
        Tmp.isCreated = false
 
    }
    
    @IBAction func deleteGameButtonClicked(_ sender: Any) {
        if Tmp.isCreated == true {
            Tmp.isCreated = false
            jsonGame.gamesObject?.games.remove(at: Tmp.tmpGame)
            jsonGame.save()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
            self.addChild(nextViewController)
            nextViewController.view.frame = self.view.frame
            self.view.addSubview(nextViewController.view)
            
        }
        else{
            Tmp.isCreated = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainView")
            self.addChild(nextViewController)
            nextViewController.view.frame = self.view.frame
            self.view.addSubview(nextViewController.view)
        }
    }
    
  
}



