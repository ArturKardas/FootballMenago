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
}
