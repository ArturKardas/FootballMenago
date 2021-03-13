//
//  TeamViewController.swift
//  FootballMenago
//
//  Created by Artur on 16/10/2020.
//

import UIKit

class PlayerCell: UITableViewCell {
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var surnameTextField: UILabel!
    @IBOutlet weak var positionTextField: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var birthDateTextField: UILabel!
    
}

class PlayerChoosenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var teamName: UILabel!
    
    var jsonClassTeams: JsonClassTeams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Zespół")
        jsonClassTeams = JsonClassTeams()
        
        teamName.text = jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].names.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCell
        
        cell.numberText.text = jsonClassTeams?.getNumber(team: Tmp.tmpTeam, player: indexPath.row)
        cell.positionTextField.text = jsonClassTeams?.getPosition(team: Tmp.tmpTeam, player: indexPath.row)
        cell.nameText.text = jsonClassTeams?.getName(team: Tmp.tmpTeam, player: indexPath.row)
        cell.surnameTextField.text = jsonClassTeams?.getSurname(team: Tmp.tmpTeam, player: indexPath.row)
        cell.birthDateTextField.text = jsonClassTeams?.getDateOfBirthString(team: Tmp.tmpTeam, player: indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        Tmp.tmpPlayer = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
        

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerPlayerCell")
        return header
    }

    @IBAction func deleteButtonClicked(_ sender: Any) {
        // MARK: zusunięcie zawodnika
        
        let alert = UIAlertController(title: "UWAGA!!!", message: "Czy chcesz usunąć tę drużynę?", preferredStyle: UIAlertController.Style.alert)
        
        let tak = UIAlertAction(title: "Tak", style: .default, handler:{(action) -> Void in self.deleteTeam()})
        let nie = UIAlertAction(title: "Nie", style: .cancel, handler:{(action) -> Void in print("nie zakończono meczu")})
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func deleteTeam() {
        jsonClassTeams?.teamsObject?.teams.remove(at: Tmp.tmpTeam)
        jsonClassTeams?.save()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "teamsChooseVC")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
        
    }
    
    @IBAction func settingsButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Edycja drużyny", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let team = jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam]
        
        alert.addTextField()
        alert.textFields![0].text = "Nazwa"
        alert.textFields![0].isUserInteractionEnabled = false
        alert.textFields![0].textAlignment = .center
        
        alert.addTextField()
        alert.textFields![1].text = team?.title
        alert.textFields![1].keyboardType = UIKeyboardType.asciiCapable
        
        alert.addTextField()
        alert.textFields![2].text = "Rocznik"
        alert.textFields![2].isUserInteractionEnabled = false
        alert.textFields![2].textAlignment = .center
        
        alert.addTextField()
        alert.textFields![3].keyboardType = UIKeyboardType.numberPad
        alert.textFields![3].text = String((team?.age)!)
        alert.textFields![3].frame.size.height = 60
        
        let tak = UIAlertAction(title: "OK", style: .default, handler:{(action) -> Void in self.editTeam(name: alert.textFields![1].text!, age: alert.textFields![3].text!)})
        let nie = UIAlertAction(title: "Anuluj", style: .cancel, handler:{(action) -> Void in })
        nie.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(tak)
        alert.addAction(nie)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func editTeam(name: String, age: String) {
        jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].title = name
        jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].age = Int(age)!
        jsonClassTeams?.save()
        
        teamName.text = jsonClassTeams?.teamsObject?.teams[Tmp.tmpTeam].title
    }
}

