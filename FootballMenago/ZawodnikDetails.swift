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
            HStack {
                Text(zawodnik.name)
                    .font(.title)
                    
                
                Text(zawodnik.surname)
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
                
            }
            .padding(.leading)
            
            Text(zawodnik.position)
            Spacer()

        }
        .padding(.top, -18)
    }
}

struct Zawodnik_Previews: PreviewProvider {
    static var previews: some View {
        ZawodnikDetails(zawodnik: zawodnikDane[0])
    }
}
