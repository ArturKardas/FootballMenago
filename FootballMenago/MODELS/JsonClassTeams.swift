//
//  JsonClass.swift
//  FootballMenago
//
//  Created by Artur on 10/12/2020.
//

import Foundation

class JsonClassTeams{
    //obiekt który przechowuje drużyny
    var teamsObject: Teams?
    
    init(){
        //odczytywanie pliku
        guard let path = Bundle.main.path(forResource: "zawodnicy", ofType: "json") else {
            print("Nie ma takiego pliku")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do{
            let jsonData = try Data(contentsOf: url)
            teamsObject = try JSONDecoder().decode( Teams.self, from: jsonData)
//            if let teams = teamsObject{
//                print(teams)
//            }else{
//                print("no nie pykło")
//            }
        }catch{
            print("Error: \(error)")
        }
    }
    
    func saveObjectToJsonFile(){
        guard let path = Bundle.main.path(forResource: "zawodnicy", ofType: "json") else {
            print("Nie ma takiego pliku")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
//        zapisywanie do formy json
        let encoder = JSONEncoder()

        do{
            try encoder.encode(teamsObject).write(to: url)
        }catch{
            print("Error: \(error)")
        }
    }
    
    func addTeam(name: String, age: Int){
        let names = [String]()
        let numbers = [Int]()
        let team = Team(title: name, age: age, names: names, numbers: numbers)
        
        teamsObject?.teams.append(team)
        
        
    }
    
    func getName(team: Int, player: Int) -> String{
        return (teamsObject?.teams[team].names[player])!
    }
    
    func getNumber(team: Int, player: Int) -> String{
        return String((teamsObject?.teams[team].numbers[player])!)
    }
    
    func getAge(team: Int) -> String{
        return String((teamsObject?.teams[team].age)!)
    }
    
    
    
    
}
