//
//  PlayerViewController.swift
//  FootballMenago
//
//  Created by Artur on 10/12/2020.
//

import UIKit

class PlayerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet weak var textFieldPosition: UITextField!
    @IBOutlet weak var textFieldBirthDate: UITextField!
    var jsonClassTeams: JsonClassTeams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Zawodnik Edycja")
        
        jsonClassTeams = JsonClassTeams()
        
        textFieldName.text = jsonClassTeams?.getName(team: Tmp.tmpTeam, player: Tmp.tmpPlayer)
        textFieldSurname.text = jsonClassTeams?.getSurname(team: Tmp.tmpTeam, player: Tmp.tmpPlayer)
        textFieldNumber.text = jsonClassTeams?.getNumber(team: Tmp.tmpTeam, player: Tmp.tmpPlayer)
        textFieldPosition.text = jsonClassTeams?.getPosition(team: Tmp.tmpTeam, player: Tmp.tmpPlayer)
        textFieldBirthDate.text = jsonClassTeams?.getDateOfBirthString(team: Tmp.tmpTeam, player: Tmp.tmpPlayer)
        
    }
    
    @IBAction func deletePlayer(_ sender: Any) {
        let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz usunąć zawodnika?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.deletePlayer()})
        let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie usunięto zawodnika")})
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        jsonClassTeams?.setName(team: Tmp.tmpTeam, player: Tmp.tmpPlayer, name: textFieldName.text!)
        jsonClassTeams?.setSurname(team: Tmp.tmpTeam, player: Tmp.tmpPlayer, surname: textFieldSurname.text!)
        jsonClassTeams?.setNumber(team: Tmp.tmpTeam, player: Tmp.tmpPlayer, number: textFieldNumber.text!)
        jsonClassTeams?.setPosition(team: Tmp.tmpTeam, player: Tmp.tmpPlayer, position: textFieldPosition.text!)
        jsonClassTeams?.setDateOfBirth(team: Tmp.tmpTeam, player: Tmp.tmpPlayer, date: textFieldBirthDate.text!)
        
        jsonClassTeams?.save()
        
        // create the alert
        let alert = UIAlertController(title: "zapisano zmiany :D", message: "", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func deletePlayer(){
        jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].names.remove(at: Tmp.tmpPlayer)
        jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].numbers.remove(at: Tmp.tmpPlayer)
        jsonClassTeams?.save()

        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TeamView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
}
