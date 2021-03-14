//
//  BenchViewController.swift
//  FootballMenago
//
//  Created by Artur on 04/02/2021.
//

import UIKit

class PlayerBenchMatchCell: UITableViewCell {
    @IBOutlet weak var numberText: UILabel!
    @IBOutlet weak var surnameTextField: UILabel!
    @IBOutlet weak var positionTextField: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var birthDateTextField: UILabel!
    
}

class BenchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let jsonTeams = JsonClassTeams()
    let jsonGames = JsonClassGames()
    
    var selected: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsMultipleSelection = true
        
        let arrayRange: Int = (jsonTeams.teamsObject?.teams[Tmp.tmpTeam].names.count)!
        let array = Array(0 ..< arrayRange)
        Tmp.restTeam = Array(Set(array).subtracting(Tmp.tmpFirstTeam))
        print(Tmp.restTeam)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tmp.restTeam.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerBenchMatchCell") as! PlayerBenchMatchCell
        
        cell.numberText.text = jsonTeams.getNumber(team: Tmp.tmpTeam, player: Tmp.restTeam[indexPath.row])
        cell.positionTextField.text = jsonTeams.getPosition(team: Tmp.tmpTeam, player: Tmp.restTeam[indexPath.row])
        cell.nameText.text = jsonTeams.getName(team: Tmp.tmpTeam, player: Tmp.restTeam[indexPath.row])
        cell.surnameTextField.text = jsonTeams.getSurname(team: Tmp.tmpTeam, player: Tmp.restTeam[indexPath.row])
        cell.birthDateTextField.text = jsonTeams.getDateOfBirthString(team: Tmp.tmpTeam, player: Tmp.restTeam[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected.append(Tmp.restTeam[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let i = selected.firstIndex(of: Tmp.restTeam[indexPath.row])
        selected.remove(at: i!)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerPlayerBenchCell")
        return header
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        let index = selected.count
        jsonGames.gamesObject?.games[Tmp.tmpGame].secondTeamSize = index
        
        for i in 0..<index{
            jsonGames.addPlayerToBenchTeam(name: jsonTeams.getName(team: Tmp.tmpTeam, player: selected[i]), number: jsonTeams.getNumber(team: Tmp.tmpTeam, player: selected[i]), position: jsonTeams.getPosition(team: Tmp.tmpTeam, player: selected[i]), surname: jsonTeams.getSurname(team: Tmp.tmpTeam, player: selected[i]))
        }
        jsonGames.save()
        Tmp.tmpBenchTeam = selected
    }
    
    
}
