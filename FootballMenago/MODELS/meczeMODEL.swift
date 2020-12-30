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
    var name: String
    var mainTeamSize: Int
    var secondTeamSize: Int
    var teamName: String
    var age: Int
    var date: String
    var firstTeam: [Int]
    var players:[[String]]
}


