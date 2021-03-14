//
//  TeamChoosenMatchViewController.swift
//  FootballMenago
//
//  Created by Artur on 28/01/2021.
//

import UIKit

class TeamChoosenMatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var jsonClassTeams: JsonClassTeams?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonClassTeams = JsonClassTeams()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonClassTeams?.teamsObject?.teams.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! TeamCell
        
        cell.nameTeamText.text = jsonClassTeams?.teamsObject?.teams[indexPath.row].title
        cell.ageTeamText.text = String((jsonClassTeams?.teamsObject?.teams[indexPath.row].age)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerTeamCell")
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Tmp.tmpTeam = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "newMatchView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
}
