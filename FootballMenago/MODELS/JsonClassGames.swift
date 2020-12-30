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
        //odczytywanie pliku
        guard let path = Bundle.main.path(forResource: "mecze", ofType: "json") else {
            print("Nie ma takiego pliku")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do{
            let jsonData = try Data(contentsOf: url)
            gamesObject = try JSONDecoder().decode( Games.self, from: jsonData)
            if let games = gamesObject{
                print(games)
            }else{
                print("no nie pykło")
          }
        }catch{
            print("Error: \(error)")
        }
    }
    
    func getFirstTeamSize(game: Int) ->  Int {
        return (gamesObject?.games[game].mainTeamSize)!
    }
    
    func checkFirstSquad(game: Int, player: Int) -> Bool{
        if (gamesObject?.games[game].players[player][11] == "1"){
            return true
        }else{
            return false
        }
    }
    
    func getName(game: Int, player: Int) ->  String {
        return (gamesObject?.games[game].players[player][0])!
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
