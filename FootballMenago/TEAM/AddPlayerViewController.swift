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
    @IBOutlet weak var textSurname: UITextField!
    @IBOutlet weak var textPosition: UITextField!
    @IBOutlet weak var textBirthDate: UITextField!
    
    @IBOutlet weak var buttonDODAJ: UIButton!
    
    var jsonClassTeams: JsonClassTeams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
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
        
        let name = textName.text
        let surname = textSurname.text
        let number = Int(textNumber.text!)
        let position = textPosition.text
        let birthDate = textBirthDate.text
        
        jsonClassTeams?.addPlayer(name: name!, surname: surname!, number: number!, position: position!, birthDate: birthDate!)
        
    }
    
}
