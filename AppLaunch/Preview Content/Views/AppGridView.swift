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
    
    init(viewModel: AppScanner, appWillClose: Binding<Bool> = Binding.constant(false)) {
        self._viewModel = Bindable(viewModel)
        self._appWillClose = appWillClose
    }
    
    var body: some View {
        GeometryReader { geometry in
            let iconSize = geometry.size.width / ((CGFloat(viewModel.columns) * 2) + 1)
            let verticalSpacing = (geometry.size.height - (iconSize * CGFloat(viewModel.rows))) / CGFloat(viewModel.rows + 1)
            let gridRows = Array(repeating: GridItem(.fixed(iconSize), spacing: verticalSpacing * 0.8), count: viewModel.rows)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridRows, alignment: .top, spacing: 0) {
                    ForEach(viewModel.apps) { app in
                        AppIconView(app: app, iconSize: iconSize) {
                            viewModel.launchApp(app)
                            appWillClose = true
                        }
                    }
                }
                
            }
            .scrollTargetBehavior(.paging)
        }
        
    }
}
