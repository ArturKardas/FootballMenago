//
//  HistoryViewController.swift
//  FootballMenago
//
//  Created by Artur on 25/10/2020.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var jsonGame: JsonClassGames?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (jsonGame?.gamesObject?.games.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = (jsonGame?.gamesObject?.games[indexPath.row].name)! + "  " + (jsonGame?.gamesObject?.games[indexPath.row].teamName)!
        cell.backgroundColor = UIColor.secondaryLabel
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        Variables.tmpGame = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GameHistoryView")
        self.addChild(nextViewController)
        nextViewController.view.frame = self.view.frame
        self.view.addSubview(nextViewController.view)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonGame = JsonClassGames()
        
        print("Historia")
    }


}
