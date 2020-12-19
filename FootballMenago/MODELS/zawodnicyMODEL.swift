//
//  zawodnicyMODEL.swift
//  FootballMenago
//
//  Created by Artur on 18/11/2020.
//

import Foundation

struct Teams: Codable{
    var teams: [Team]
}

struct Team: Codable{
    var title: String
    var names: [String]
    var numbers: [Int]
}

