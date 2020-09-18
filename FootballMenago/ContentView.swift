//
//  ContentView.swift
//  FootballMenago
//
//  Created by Artur Kardas  on 16/09/2020.
//  Copyright © 2020 Artur Kardas . All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZawodnikList()
        }.border(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11 Pro")
        }
    }
}
