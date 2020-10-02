//
//  Zawodnik.swift
//  FootballMenago
//
//  Created by Artur on 18/09/2020.
//  Copyright © 2020 Artur Kardas . All rights reserved.
//

import SwiftUI

struct ZawodnikDetails: View {
    var zawodnik: Zawodnik
    
    var body: some View {
        VStack {
            ZStack{
                HStack(alignment: .center) {
                    
                    Text(zawodnik.name)
                        .font(.title)
                        
                    
                    Text(zawodnik.surname)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    
                }
                .padding(.leading)
                .foregroundColor(.black)
                .background(Color.blue)
                
                
            }
            
            HStack{
                Text("Pozycja:").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Text(zawodnik.position).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }.padding(5)
            
            HStack{
                Text("Bramki:").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Text(String(zawodnik.goals)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }.padding(5)
                
            
            Spacer()

        }.background(Color.white)
    }
}

struct Zawodnik_Previews: PreviewProvider {
    static var previews: some View {
        ZawodnikDetails(zawodnik: zawodnikDane[0])
    }
}
