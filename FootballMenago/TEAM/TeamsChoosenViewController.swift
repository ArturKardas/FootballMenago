//
//  TeamsChoosenViewController.swift
//  FootballMenago
//
//  Created by Artur on 10/12/2020.
//

import UIKit

class TeamCell: UITableViewCell {
    @IBOutlet weak var nameTeamText: UILabel!
    @IBOutlet weak var ageTeamText: UILabel!
}

class TeamsChoosenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonClassTeams: JsonClassTeams?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonClassTeams?.teamsObject?.teams.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! TeamCell
        
        cell.nameTeamText.text = jsonClassTeams?.teamsObject?.teams[indexPath.row].title
        cell.ageTeamText.text = String((jsonClassTeams?.teamsObject?.teams[indexPath.row].age)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        Tmp.tmpTeam = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TeamView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerTeamCell")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Wybierz zespół")
        jsonClassTeams = JsonClassTeams()
    }

}
