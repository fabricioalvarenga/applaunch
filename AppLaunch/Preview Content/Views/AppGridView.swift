//
//  AppGrid.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppGridView: View {
    @Bindable var viewModel: AppScanner
    @Binding var appClosed: Bool
    
    private let rows: Int
    private let columns: Int
    private let apps: [AppInfo]
    private let geometry: GeometryProxy
    private let iconSize: CGFloat
    private let verticalSpacing: CGFloat
    private let gridRows: [GridItem]

    
    init(
        viewModel: AppScanner,
        rows: Int,
        columns: Int,
        apps: [AppInfo],
        geometry: GeometryProxy,
        appClosed: Binding<Bool> = Binding.constant(false)
    ) {
        self._viewModel = Bindable(viewModel)
        self.rows = rows
        self.columns = columns
        self.apps = apps
        self.geometry = geometry
        self._appClosed = appClosed
        
        iconSize = geometry.size.width / ((CGFloat(columns) * 2) + 1) 
        verticalSpacing = (geometry.size.height - (iconSize * CGFloat(rows))) / CGFloat(rows + 1)
        gridRows = Array(repeating: GridItem(.fixed(iconSize), spacing: verticalSpacing * 0.8), count: rows)
    }
    
    var body: some View {
        LazyHGrid(rows: gridRows, spacing: 0) {
            ForEach(apps) { app in
                AppIconView(app: app, iconSize: iconSize) {
                    viewModel.launchApp(app)
                    
                    withAnimation(.spring(response: 0.1, dampingFraction: 1.0)) {
                        appClosed = true
                    }
                }
            }
        }
    }
    
    func handleAppClick(_ app: AppInfo) {
        let alert = NSAlert()
        alert.messageText = "Abrindo \(app.name)"
        alert.informativeText = "App clicado: \(app.name)"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

}
