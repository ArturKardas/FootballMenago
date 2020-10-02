//
//  ZawodnikList.swift
//  FootballMenago
//
//  Created by Artur Kardas  on 16/09/2020.
//  Copyright © 2020 Artur Kardas . All rights reserved.
//

import SwiftUI



struct ZawodnikList: View {
    var body: some View {
        ZStack{
            NavigationView{
                List(zawodnikDane){ zawodnik in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                        .overlay(
                                NavigationLink(destination: ZawodnikDetails(zawodnik: zawodnik)){
                                    ZawodnikRow(zawodnik: zawodnik)
                                }
                            
                        )
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .frame(height: 40)
                        .foregroundColor(.black)
                        
                        
                    
                }
                .navigationBarTitle(Text("Zawodnicy"), displayMode: .inline)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
    
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }
           
        
        
        
    }
}

struct ZawodnikList_Previews: PreviewProvider {
    static var previews: some View {
        ZawodnikList()
        
    }
}
