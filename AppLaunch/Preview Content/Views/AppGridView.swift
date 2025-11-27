//
//  AppGrid.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppGridView: View {
    private let gridRows: [GridItem]
    private let apps: [AppItem]
    private let horizontalSpacing: CGFloat
    private let iconSize: CGFloat
    
    init(gridRows: [GridItem], apps: [AppItem], horizontalSpacing: CGFloat, iconSize: CGFloat) {
        self.gridRows = gridRows
        self.apps = apps
        self.horizontalSpacing = horizontalSpacing
        self.iconSize = iconSize
    }
    
    var body: some View {
        HStack {
            LazyHGrid(rows: gridRows, spacing: horizontalSpacing) {
                ForEach(apps) { app in
                    AppIconView(app: app, size: iconSize)
                        .onTapGesture {
                            handleAppClick(app)
                        }
                }
            }
            .padding(.horizontal, horizontalSpacing)
        }
    }
    
    func handleAppClick(_ app: AppItem) {
        let alert = NSAlert()
        alert.messageText = "Abrindo \(app.name)"
        alert.informativeText = "App clicado: \(app.name)"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

}
