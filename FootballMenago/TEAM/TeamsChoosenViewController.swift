//
//  TeamsChoosenViewController.swift
//  FootballMenago
//
//  Created by Artur on 10/12/2020.
//

import UIKit

class TeamsChoosenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonClassTeams: JsonClassTeams?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonClassTeams?.teamsObject?.teams.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.secondaryLabel
        cell.textLabel?.text = (jsonClassTeams?.teamsObject?.teams[indexPath.row].title)! + "  " + String((jsonClassTeams?.teamsObject?.teams[indexPath.row].age)!)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        Variables.tmpTeam = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TeamView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Wybierz zespół")
        jsonClassTeams = JsonClassTeams()
    }

}
