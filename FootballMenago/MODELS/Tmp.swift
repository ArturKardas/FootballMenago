//
//  Variables.swift
//  FootballMenago
//
//  Created by Artur on 10/12/2020.
//

import Foundation

struct Tmp{
    static var tmpTeam = 0
    static var tmpPlayer = 0
    static var tmpGame = 0
    
    static var tmpFirstTeam: [Int] = [] //selected players to main team
    static var tmpBenchTeam: [Int] = [] //selected players to bench
    static var restTeam: [Int] = [] // players dont selected in firtst selection
    
    static var securityFlag = false
    static var startTime: Date = Date()
    static var halfTime = 0
    
}
