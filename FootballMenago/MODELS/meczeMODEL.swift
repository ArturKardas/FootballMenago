//
//  meczeMODEL.swift
//  FootballMenago
//
//  Created by Artur on 14/12/2020.
//

import Foundation

struct Games: Codable {
    var games: [Game]
}

struct Game: Codable {
    var mainTeamSize: Int
    var secondTeamSize: Int
    var teamName: String
    var enemyTeam: String
    var age: Int
    var typeOfMatch: String
    var date: String
    var firstTeam: [Int]
    var players:[[String]]
    var bench:[[String]]
}


