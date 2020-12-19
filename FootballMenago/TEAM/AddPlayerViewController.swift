//
//  AddPlayerViewController.swift
//  FootballMenago
//
//  Created by Artur on 08/12/2020.
//

import UIKit

class AddPlayerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textNumber: UITextField!
    
    @IBOutlet weak var buttonDODAJ: UIButton!
    
    var jsonClassTeams: JsonClassTeams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textNumber.delegate = self
        jsonClassTeams = JsonClassTeams()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        if string.isEmpty == true {
            buttonDODAJ.isEnabled = false
        }else{
            buttonDODAJ.isEnabled = true
        }
        
        return allowedCharacters.isSuperset(of: characterSet)
  
    }
    
    
    
    @IBAction func addPlayer(_ sender: Any) {
        print(textName.text! as String)
        let number = Int(textNumber.text!)!
        let index = (jsonClassTeams?.teamsObject?.teams[Variables.tmpTeam].names.count)! as Int
        jsonClassTeams?.teamsObject?.teams[Variables.tmpTeam].names.insert(textName.text! as String, at: index)
        jsonClassTeams?.teamsObject?.teams[Variables.tmpTeam].numbers.insert(number, at: index)
        
        jsonClassTeams?.saveObjectToJsonFile()
    }
    
}
