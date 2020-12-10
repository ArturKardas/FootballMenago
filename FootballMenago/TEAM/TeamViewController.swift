//
//  TeamViewController.swift
//  FootballMenago
//
//  Created by Artur on 16/10/2020.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonClassTeams: JsonClassTeams?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonClassTeams?.teamsObject?.teams[Variables.tmpTeam].names.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.secondaryLabel
        cell.textLabel?.text = (jsonClassTeams?.getName(team: Variables.tmpTeam, player: indexPath.row))!+(jsonClassTeams?.getNumber(team: Variables.tmpTeam, player: indexPath.row))!
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        Variables.tmpPlayer = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Zespół")
        jsonClassTeams = JsonClassTeams()
        //parseJSON();
    }
}

