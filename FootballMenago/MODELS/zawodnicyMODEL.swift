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
    var age: Int
    var names: [String]
    var surnames: [String]
    var birthDates: [String]
    var numbers: [Int]
    var position: [String]
}

