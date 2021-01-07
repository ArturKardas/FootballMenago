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
        textFieldName.text = jsonClassTeams?.getName(team: Variables.tmpTeam, player: Variables.tmpPlayer)
        textFieldSurname.text = jsonClassTeams?.getSurname(team: Variables.tmpTeam, player: Variables.tmpPlayer)
        textFieldNumber.text = jsonClassTeams?.getNumber(team: Variables.tmpTeam, player: Variables.tmpPlayer)
        textFieldPosition.text = jsonClassTeams?.getPosition(team: Variables.tmpTeam, player: Variables.tmpPlayer)
        textFieldBirthDate.text = jsonClassTeams?.getDateOfBirthString(team: Variables.tmpTeam, player: Variables.tmpPlayer)
        
    }
    
    @IBAction func deletePlayer(_ sender: Any) {
        jsonClassTeams?.teamsObject?.teams[Variables.tmpTeam].names.remove(at: Variables.tmpPlayer)
        jsonClassTeams?.teamsObject?.teams[Variables.tmpTeam].numbers.remove(at: Variables.tmpPlayer)
        jsonClassTeams?.saveObjectToJsonFile()
    }
}
