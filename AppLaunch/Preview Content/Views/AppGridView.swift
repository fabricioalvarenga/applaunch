//
//  AppGrid.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppGridView: View {
    @Bindable var viewModel: AppScanner
    @Binding var appWillClose: Bool
    
    private let geometry: GeometryProxy
    private let iconSize: CGFloat
    private let verticalSpacing: CGFloat
    private let gridRows: [GridItem]
    
    private var appsPerPage: Int {
        viewModel.columns * viewModel.rows
    }
    
    init(viewModel: AppScanner, geometry: GeometryProxy, appWillClose: Binding<Bool> = Binding.constant(false)) {
        self.geometry = geometry
        self._viewModel = Bindable(viewModel)
        self._appWillClose = appWillClose
        
        iconSize = geometry.size.width / ((CGFloat(viewModel.columns) * 2) + 1)
        verticalSpacing = (geometry.size.height - (iconSize * CGFloat(viewModel.rows))) / CGFloat(viewModel.rows + 1)
        gridRows = Array(repeating: GridItem(.fixed(iconSize), spacing: verticalSpacing * 0.8), count: viewModel.rows)
    }
    
    var body: some View {
        LazyHGrid(rows: gridRows, alignment: .top, spacing: 0) {
            ForEach(viewModel.filteredApps) { app in
                AppIconView(app: app, iconSize: iconSize) {
                    viewModel.launchApp(app)
                    appWillClose = true
                }
            }
        }
    }
    
    func handleAppClick(_ app: AppInfo) {
        let alert = NSAlert()
        alert.messageText = "Abrindo \(String(describing: app.name))"
        alert.informativeText = "App clicado: \(String(describing: app.name))"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }

}
