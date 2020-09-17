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
        NavigationView{
            List{
                ZawodnikRow()
            }.navigationBarTitle(Text("Zawodnicy"))
            
        }
    }
}

struct ZawodnikList_Previews: PreviewProvider {
    static var previews: some View {
        ZawodnikList()
    }
}
