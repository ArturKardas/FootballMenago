//
//  HistoryViewController.swift
//  FootballMenago
//
//  Created by Artur on 25/10/2020.
//

import UIKit

class TeamHistoryCell: UITableViewCell{
    @IBOutlet weak var enemyNameText: UILabel!
    @IBOutlet weak var teamNameText: UILabel!
    @IBOutlet weak var dataText: UILabel!
}

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var jsonGame: JsonClassGames?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonGame?.gamesObject?.games.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as!TeamHistoryCell

        cell.enemyNameText.text = jsonGame?.gamesObject?.games[indexPath.row].enemyTeam
        cell.teamNameText.text = jsonGame?.gamesObject?.games[indexPath.row].teamName
        cell.dataText.text = jsonGame?.gamesObject?.games[indexPath.row].date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        Tmp.tmpGame = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GameHistoryView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "sectionGameCell")
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonGame = JsonClassGames()
        
        print("Historia")
    }


}
