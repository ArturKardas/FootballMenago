//
//  AddTeamViewController.swift
//  FootballMenago
//
//  Created by Artur on 10/12/2020.
//

import UIKit

class AddTeamViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonDODAJ: UIButton!
    @IBOutlet weak var textFieldNameTeam: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldNameTeam.delegate = self
    }
    
    @IBAction func addTeam(_ sender: Any) {
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty == true {
            buttonDODAJ.isEnabled = false
        }else{
            buttonDODAJ.isEnabled = true
        }
        return true
    }

}
