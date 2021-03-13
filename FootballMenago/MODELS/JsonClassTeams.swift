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
        
        do{
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            //giving new name to file
            let url =  path.appendingPathComponent("NIE-USUWAC.json")
            
            let jsonData = try Data(contentsOf: url)
            teamsObject = try JSONDecoder().decode( Teams.self, from: jsonData)
            
        }catch{
            let documentPath: String = Bundle.main.path(forResource: "zawodnicy", ofType: "json")!
            do {
                let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url =  path.appendingPathComponent("NIE-USUWAC.json")
                let newPath = url.path
                try FileManager.default.copyItem(atPath: documentPath, toPath: newPath)
                
                let jsonData = try Data(contentsOf: url)
                teamsObject = try JSONDecoder().decode( Teams.self, from: jsonData)
            } catch{
                print("Error: \(error)")
            }
            
        }
    }
    
    func save(){
        let encoder = JSONEncoder()
        
        do{
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            //giving new name to file
            let url =  path.appendingPathComponent("NIE-USUWAC.json")
            
            try encoder.encode(teamsObject).write(to: url)
        }catch{
            print("NNNNNNNNNNNNNNN")
            print("Error: \(error)")
        }
    }
    
    func addTeam(name: String, age: Int){
        let names = [String]()
        let surnames = [String]()
        let numbers = [Int]()
        let position = [String]()
        let birthDate = [String]()
        let team = Team(title: name, age: age, names: names, surnames: surnames, birthDates: birthDate,numbers: numbers, position: position)
        
        teamsObject?.teams.append(team)
        
        
    }
    
    func  addPlayer(name: String, surname: String, number: Int, position: String, birthDate: String){
        
        let index = (teamsObject?.teams[Tmp.tmpTeam].names.count)! as Int
        
        teamsObject?.teams[Tmp.tmpTeam].names.insert(name, at: index)
        teamsObject?.teams[Tmp.tmpTeam].surnames.insert(surname, at: index)
        teamsObject?.teams[Tmp.tmpTeam].numbers.insert(number, at: index)
        teamsObject?.teams[Tmp.tmpTeam].position.insert(position, at: index)
        teamsObject?.teams[Tmp.tmpTeam].birthDates.insert(birthDate, at: index)
        
        save()
    }
    
    func getName(team: Int, player: Int) -> String{
        return (teamsObject?.teams[team].names[player])!
    }
    
    func setName(team: Int, player: Int, name: String){
        teamsObject?.teams[team].names[player] = name
    }
    
    func getSurname(team: Int, player: Int) -> String{
        return (teamsObject?.teams[team].surnames[player])!
    }
    
    func setSurname(team: Int, player: Int, surname: String){
        teamsObject?.teams[team].surnames[player] = surname
    }
    
    func getNumber(team: Int, player: Int) -> String{
        return String((teamsObject?.teams[team].numbers[player])!)
    }
    
    func setNumber(team: Int, player: Int, number: String) {
        teamsObject?.teams[team].numbers[player] = Int(number)!
    }
    
    func getTeamAge(team: Int) -> String{
        return String((teamsObject?.teams[team].age)!)
    }
    
    func setTeamAge(team: Int, age: String) {
        teamsObject?.teams[team].age = Int(age)!
    }
    
    func  getPosition(team: Int, player: Int) -> String {
        return (teamsObject?.teams[team].position[player])!
    }
    
    func setPosition(team: Int, player: Int, position: String){
        teamsObject?.teams[team].position[player] = position
    }
    
    func getDateOfBirthString(team: Int, player: Int) -> String {
        return (teamsObject?.teams[team].birthDates[player])!
    }
    
    func setDateOfBirth(team: Int, player: Int, date: String){
        teamsObject?.teams[team].birthDates[player] = date
    }
    
    
    
}
