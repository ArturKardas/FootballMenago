//
//  JsonClassGames.swift
//  FootballMenago
//
//  Created by Artur on 14/12/2020.
//

import Foundation

class JsonClassGames{
    var gamesObject: Games?
    
    init(){
        
        do{
            //odczytywanie pliku
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url =  path.appendingPathComponent("NIE-USUWAC-HISTORIA.json")
            
            let jsonData = try Data(contentsOf: url)
            gamesObject = try JSONDecoder().decode( Games.self, from: jsonData)
        }catch{
            
            let documentPath: String = Bundle.main.path(forResource: "mecze", ofType: "json")!
            
            do {
                let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url =  path.appendingPathComponent("NIE-USUWAC-HISTORIA.json")
                let newPath = url.path
                try FileManager.default.copyItem(atPath: documentPath, toPath: newPath)
                
                let jsonData = try Data(contentsOf: url)
                gamesObject = try JSONDecoder().decode( Games.self, from: jsonData)
            } catch{
                print("Error: \(error)")
            }
            
        }
    }
    
    func addGame(teamName: String,enemy: String, teamSize: Int, data: String, category: String, age: Int, hour: String, place: String, timeHalf: Int){
        
        let game = Game(mainTeamSize: teamSize, secondTeamSize: 0, teamName: teamName, enemyTeam: enemy, age: age, typeOfMatch: category, timeHalf: timeHalf, place: place, date: data, hour: hour ,firstHalfAlly: 0, firstHalfEnemy: 0, fullTimeAlly: 0, fullTimeEnemy: 0, fastNote: "", attackFazePlus:"", attackFazeMinus: "", defenseFazePlus: "", defenseFazeMinus: "", other: [""], goals: [], players:[], bench: [])
        
        gamesObject?.games.append(game)
    }
    
    func addPlayerToMainTeam(name: String, number: String, position: String, surname: String) {
        let string: [String] = ["\(name)","\(number)","","X","0","0","0","0","","0","","X","\(position)","\(surname)","0"]
        gamesObject?.games[Tmp.tmpGame].players.append(string)
        
        
    }
    
    func addPlayerToBenchTeam(name: String, number: String, position: String, surname: String) {
        let string: [String] = ["\(name)","\(number)","X","","0","0","0","0","","0","","","\(position)","\(surname)","0"]
        gamesObject?.games[Tmp.tmpGame].bench.append(string)
        
        
    }
    
    func save() {
        let encoder = JSONEncoder()
        do{
            //odczytywanie pliku
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let url =  path.appendingPathComponent("NIE-USUWAC-HISTORIA.json")
            
            try encoder.encode(gamesObject).write(to: url)
        }catch{
            do {
                let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url =  path.appendingPathComponent("NIE-USUWAC-HISTORIA.json")
                
                try encoder.encode(gamesObject).write(to: url)
            } catch{
                print("Error: \(error)")
            }
            
        }
    }
    
    func getFirstTeamSize(game: Int) ->  Int {
        return (gamesObject?.games[game].mainTeamSize)!
    }
    
    func getName(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][0])!
    }
    
    func getSurname(game: Int, player: Int) -> String{
        return (gamesObject?.games[game].players[player][13])!
    }
    
    func getNumber(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][1])!
    }
    
    func get18(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][2])!
    }
    
    func get7(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][3])!
    }
    
    func getNumbersOfGoals(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][4])!
    }
    
    func getAssists(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][5])!
    }
    
    func getNumbersOFYellowCards(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][6])!
    }
    
    func get7NumbersOfRedCards(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][7])!
    }
    
    func getGrade(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][8])!
    }
    
    func getPlayedTime(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][9])!
    }
    
    func getDescription(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][10])!
    }
}
