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
        
        let team = games.gamesObject?.games[Variables.tmpGame]
        
        //Save a copy
        //giving  path to directory
        do{
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            //giving new name to file
            let newUrl =  path.appendingPathComponent("Test\(Date.init()).xlsx")
            let excelNewPath = newUrl.path
            
            try FileManager.default.copyItem(atPath: documentPath, toPath: excelNewPath)
            
            let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(excelNewPath)
            let firstWorksheet: BRAWorksheet = spreadsheet.workbook.worksheets[0] as! BRAWorksheet
            
            for i in 0..<((team?.players.count)!){
                firstWorksheet.cell(forCellReference: "B\(5+i)", shouldCreate: true)?.setStringValue("\(team?.players[i][0] ?? "nie zczytano")")
            }
            
            let komorka: String = (firstWorksheet.cell(forCellReference: "B5")?.stringValue())!
            spreadsheet.save()
            
            print(komorka)
        }catch{
            print("nie pykło")
        }
    }
    
}
