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
    
    var jsonClassTeams: JsonClassTeams?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Zespół")
        jsonClassTeams = JsonClassTeams()
        //parseJSON();
    }
}

