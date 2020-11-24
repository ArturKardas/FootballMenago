//
//  TeamViewController.swift
//  FootballMenago
//
//  Created by Artur on 16/10/2020.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource {
    
    var teamsObject: Teams?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (teamsObject?.teams[0].names.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.secondaryLabel
        cell.textLabel?.text = teamsObject!.teams[0].names[indexPath.row]+String(teamsObject!.teams[0].numbers[indexPath.row])
        cell.textLabel?.textColor = UIColor.white
        //cell.textLabel?.textAlignment = NSTextAlignment.center
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Zespół")
        
        parseJSON();
    }
    
    
    //JSON
    private func parseJSON(){

        guard let path = Bundle.main.path(forResource: "zawodnicy", ofType: "json") else {
            print("Nie ma takiego pliku")
            return
        }
        print(path)
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            teamsObject = try JSONDecoder().decode( Teams.self, from: jsonData)
            if let teams = teamsObject{
                print(teams)
            }
            else{
                print("no nie pykło")
            }
            teamsObject!.teams[0].numbers[2]=Int.random(in:1..<100)
            
            ///////////zapisywanie do formy json
            let encoder = JSONEncoder()
            //encoder.outputFormatting = .prettyPrinted

            
            try encoder.encode(teamsObject).write(to: url)
            
        }catch{
            print("Error: \(error)")
        }
    }
}

