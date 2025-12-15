//
//  AppGrid.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppGridView: View {
    @State private var currentPage = 0
    @Bindable var viewModel: AppScanner
    @Binding var appWillClose: Bool

    init(
        viewModel: AppScanner,
        appWillClose: Binding<Bool> = Binding.constant(false)
    ) {
        self._viewModel = Bindable(viewModel)
        self._appWillClose = appWillClose
    }

    var body: some View {
        GeometryReader { outerGeometry in
            let columnWidth = outerGeometry.size.width / ((CGFloat(viewModel.columns) * 2) + 1)
            let verticalSpacing = (outerGeometry.size.height - (columnWidth * CGFloat(viewModel.rows))) / CGFloat(viewModel.rows + 1)
            let gridRows = Array(repeating: GridItem(.fixed(columnWidth), spacing: verticalSpacing), count: viewModel.rows)

            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: gridRows, alignment: .top, spacing: 0) {
                        ForEach(viewModel.apps) { app in
                            AppIconView(app: app, iconSize: columnWidth) {
                                viewModel.launchApp(app)
                                appWillClose = true
                            }
                        }
                    }
                    .background(
                        GeometryReader { innerGeometry in
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: innerGeometry.frame(in: .global).minX)
                                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                                    let pageWidth = outerGeometry.size.width
                                    let newPage = Int(round(-offset / pageWidth))
                                    
                                    if newPage >= 0 && newPage < viewModel.totalPages {
                                        currentPage = newPage
                                    }
                                }
                        }
                    )
                }
                .frame(maxHeight: .infinity)
                .scrollTargetBehavior(.paging)
                
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.totalPages, id: \.self) { page in
                        Circle()
                            .fill(page == currentPage ? .white : .white.opacity(0.5))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 36)
            }
            
        }
    }
}
