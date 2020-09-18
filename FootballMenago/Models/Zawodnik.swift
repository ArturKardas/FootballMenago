//
//  Zawodnik.swift
//  FootballMenago
//
//  Created by Artur on 18/09/2020.
//  Copyright © 2020 Artur Kardas . All rights reserved.
//

import CoreLocation
import SwiftUI


struct Zawodnik: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var surname: String
    var position: String

}

