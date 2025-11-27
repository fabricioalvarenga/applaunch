//
//  AppItem.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppItem: Identifiable {
    let id: UUID
    let name: String
    let icon: String
    let color: Color
    
    init(id: UUID = UUID(), name: String, icon: String, color: Color) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }
}

