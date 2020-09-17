//
//  ZawodnikRow.swift
//  FootballMenago
//
//  Created by Artur Kardas  on 16/09/2020.
//  Copyright © 2020 Artur Kardas . All rights reserved.
//

import SwiftUI

struct ZawodnikRow: View {
    var body: some View {
        HStack {
            Text("Domi Dominika")
            Spacer()
            Text("Napastnik")
        }
    }
}

struct ZawodnikRow_Previews: PreviewProvider {
    static var previews: some View {
        ZawodnikRow()
    }
}
