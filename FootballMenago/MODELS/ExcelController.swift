//
//  ExcelController.swift
//  FootballMenago
//
//  Created by Artur on 12/01/2021.
//

import Foundation
import UIKit
import XlsxReaderWriter

class ExcelController {
    
    var games = JsonClassGames()
    
    func printExcel(){
        let documentPath: String = Bundle.main.path(forResource: "a", ofType: "xlsx")!
        
        let team = games.gamesObject?.games[Tmp.tmpGame]
        
        do{
            //giving  path to directory
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let date = Date()
            let calendar = Calendar.current.dateComponents([.day,.month,.year, .minute, .second], from: date)
            let year = calendar.year
            let day = calendar.day
            let month = calendar.month
            let min = calendar.minute
            let sec = calendar.second
            
            //giving new name to file
            let newUrl =  path.appendingPathComponent("\(day ?? Int.random(in: 0...99))_\(month ?? Int.random(in: 0...99))_\(year ??   Int.random(in: 0...99))_\(min ??  Int.random(in: 0...99))\(sec ??  Int.random(in: 0...99)).xlsx")
            let excelNewPath = newUrl.path
            
            //Save a copy
            try FileManager.default.copyItem(atPath: documentPath, toPath: excelNewPath)
            
            let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(excelNewPath)
            let firstWorksheet: BRAWorksheet = spreadsheet.workbook.worksheets[0] as! BRAWorksheet
            
            firstWorksheet.cell(forCellReference: "A3", shouldCreate: true)?.setStringValue("\(team?.date ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "C3", shouldCreate: true)?.setStringValue("\(team?.hour ?? "nie zczytano")/\(team?.place ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "E3", shouldCreate: true)?.setStringValue("\(team?.typeOfMatch ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "I3", shouldCreate: true)?.setStringValue("\(team?.teamName ?? "nie zczytano") - \(team?.enemyTeam ?? "nie zaczytano")")
            firstWorksheet.cell(forCellReference: "O3", shouldCreate: true)?.setStringValue("\(team?.firstHalfAlly ?? 0)")
            firstWorksheet.cell(forCellReference: "P3", shouldCreate: true)?.setStringValue("\(team?.firstHalfEnemy ?? 0)")
            firstWorksheet.cell(forCellReference: "Q3", shouldCreate: true)?.setStringValue("\(team?.fullTimeAlly ?? 0)")
            firstWorksheet.cell(forCellReference: "R3", shouldCreate: true)?.setStringValue("\(team?.fullTimeEnemy ?? 0)")
            
            firstWorksheet.cell(forCellReference: "G4", shouldCreate: true)?.setStringValue("\"\(team?.mainTeamSize ?? 0)\"")
            
            var index: Int = 0
            
            for i in 0..<((team?.players.count)!){
                firstWorksheet.cell(forCellReference: "B\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][0] ?? "nie zczytano") \(team?.players[i][13] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "D\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][12] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "E\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][1] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "F\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][2] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "G\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][3] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "H\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][9] ?? "nie zczytano")")
                
                if team?.players[i][4] == "0"{
                    firstWorksheet.cell(forCellReference: "I\(5+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "I\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][4] ?? "nie zczytano")")
                }
                
                if team?.players[i][5] == "0"{
                    firstWorksheet.cell(forCellReference: "J\(5+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "J\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][5] ?? "nie zczytano")")
                }
                
                if team?.players[i][6] == "0"{
                    firstWorksheet.cell(forCellReference: "K\(5+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "K\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][6] ?? "nie zczytano")")
                }
                
                if team?.players[i][7] == "0"{
                    firstWorksheet.cell(forCellReference: "L\(5+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "L\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][7] ?? "nie zczytano")")
                }
                
                firstWorksheet.cell(forCellReference: "M\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][8] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "N\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][10] ?? "nie zczytano")")
            }
            index = index + (team?.players.count)! + 5
            
            for i in 0..<((team?.bench.count)!){
                firstWorksheet.cell(forCellReference: "B\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][0] ?? "nie zczytano") \(team?.bench[i][13] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "D\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][12] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "E\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][1] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "F\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][2] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "G\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][3] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "H\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][9] ?? "nie zczytano")")
                
                if team?.bench[i][4] == "0"{
                    firstWorksheet.cell(forCellReference: "I\(index+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "I\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][4] ?? "nie zczytano")")
                }
                
                if team?.bench[i][5] == "0"{
                    firstWorksheet.cell(forCellReference: "J\(index+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "J\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][5] ?? "nie zczytano")")
                }
                
                if team?.bench[i][6] == "0"{
                    firstWorksheet.cell(forCellReference: "K\(index+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "K\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][6] ?? "nie zczytano")")
                }
                
                if team?.bench[i][7] == "0"{
                    firstWorksheet.cell(forCellReference: "L\(index+i)", shouldCreate: true)?.setStringValue("")
                }else{
                    firstWorksheet.cell(forCellReference: "L\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][7] ?? "nie zczytano")")
                }
                
                firstWorksheet.cell(forCellReference: "M\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][8] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "N\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][10] ?? "nie zczytano")")
            }
            
            for i in 0 ..< (team?.goals.count)! {
                firstWorksheet.cell(forCellReference: "O\(24+i)", shouldCreate: true)?.setStringValue("\(team?.goals[i][0] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "P\(24+i)", shouldCreate: true)?.setStringValue("\(team?.goals[i][1] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "Q\(24+i)", shouldCreate: true)?.setStringValue("\(team?.goals[i][2] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "R\(24+i)", shouldCreate: true)?.setStringValue("\(team?.goals[i][3] ?? "nie zczytano")")
            }
            
            //Nototaki zapisywanie
            firstWorksheet.cell(forCellReference: "A\(27)", shouldCreate: true)?.setStringValue("\(team?.other[0] ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "A\(37)", shouldCreate: true)?.setStringValue("\(team?.attackFazePlus ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "E\(37)", shouldCreate: true)?.setStringValue("\(team?.attackFazeMinus ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "H\(37)", shouldCreate: true)?.setStringValue("\(team?.defenseFazePlus ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "L\(37)", shouldCreate: true)?.setStringValue("\(team?.defenseFazeMinus ?? "nie zczytano")")
            let komorka: String = (firstWorksheet.cell(forCellReference: "B5")?.stringValue())!
            spreadsheet.save()
            
            print(komorka)
        }catch{
            print("nie pykło")
        }
    }
    
}
