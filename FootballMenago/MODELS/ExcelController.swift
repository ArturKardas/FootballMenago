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
            
            //giving new name to file
            let newUrl =  path.appendingPathComponent("Test\(Date.init()).xlsx")
            let excelNewPath = newUrl.path
            
            //Save a copy
            try FileManager.default.copyItem(atPath: documentPath, toPath: excelNewPath)
            
            let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(excelNewPath)
            let firstWorksheet: BRAWorksheet = spreadsheet.workbook.worksheets[0] as! BRAWorksheet
            
            firstWorksheet.cell(forCellReference: "A3", shouldCreate: true)?.setStringValue("\(team?.date ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "E3", shouldCreate: true)?.setStringValue("\(team?.typeOfMatch ?? "nie zczytano")")
            firstWorksheet.cell(forCellReference: "I3", shouldCreate: true)?.setStringValue("\(team?.teamName ?? "nie zczytano") - \(team?.enemyTeam ?? "nie zaczytano")")
            
            var index: Int = 0
            
            for i in 0..<((team?.players.count)!){
                firstWorksheet.cell(forCellReference: "B\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][0] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "D\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][12] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "E\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][1] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "F\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][2] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "G\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][3] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "H\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][9] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "I\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][4] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "J\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][5] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "K\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][6] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "L\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][7] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "M\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][8] ?? "nie zczytano")")
            }
            index = index + (team?.players.count)! + 5
            
            for i in 0..<((team?.bench.count)!){
                firstWorksheet.cell(forCellReference: "B\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][0] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "D\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][12] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "E\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][1] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "F\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][2] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "G\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][3] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "H\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][9] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "I\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][4] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "J\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][5] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "K\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][6] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "L\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][7] ?? "nie zczytano")")
                firstWorksheet.cell(forCellReference: "M\(index+i)", shouldCreate: true)?.setStringValue("\(team?.bench[i][8] ?? "nie zczytano")")
            }
            
            let komorka: String = (firstWorksheet.cell(forCellReference: "B5")?.stringValue())!
            spreadsheet.save()
            
            print(komorka)
        }catch{
            print("nie pykło")
        }
    }
    
}
