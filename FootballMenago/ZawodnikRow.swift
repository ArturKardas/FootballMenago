//
//  ZawodnikRow.swift
//  FootballMenago
//
//  Created by Artur Kardas  on 16/09/2020.
//  Copyright © 2020 Artur Kardas . All rights reserved.
//

import SwiftUI

struct ZawodnikRow: View {
    var zawodnik: Zawodnik
    
    var body: some View {
        HStack {
            Text(zawodnik.name).font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
            Text(zawodnik.surname)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            Text(zawodnik.position)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
        }
    }
}

struct ZawodnikRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZawodnikRow(zawodnik: zawodnikDane[0]
        )
        }
    }
}
