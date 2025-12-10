//
//  LaunchpadView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct LaunchpadView: View {
    @Bindable var viewModel: AppScanner
    @State private var searchText = ""
    @Binding var appWillClose: Bool
    
    private var columns: Int
    private var rows: Int
    
    init(
        viewModel: AppScanner,
        columns: Int = 7,
        rows: Int = 5,
        appWillClose: Binding<Bool> = Binding.constant(false)
    ) {
        self._viewModel = Bindable(viewModel)
        self.columns = columns
        self.rows = rows
        self._appWillClose = appWillClose
    }
    
    private var appsPerPage: Int {
        columns * rows
    }
    
    // Filtra os apps com base no campo de pesquisa
    // Adiciona uma coluna de apps em branco no iníco do array
    // Adiciona uma coluna de apps em branco entre cada coluna do array
    // Adiciona a quantidade de apps em branco necessária para que ...
    // ... cada página fique com a quantidade uniforme de apps
    private var filteredApps: [AppInfo] {
        var filledApps: [AppInfo] = []
        
        if searchText.isEmpty {
            filledApps = viewModel.apps
        } else {
            filledApps = viewModel.apps.filter { app in
                guard let name = app.name else { return false }
                return name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        let elementsPerPage = rows * columns
        let totalPages = (filledApps.count + elementsPerPage - 1) / elementsPerPage
        let totalColumnsPerPage = 2 * columns + 1
        let totalElements = totalPages * rows * totalColumnsPerPage
        
        var arrayIndex = 0
        var result: [AppInfo] = []

        // Fill result array with blank elements
        for _ in 0..<totalElements {
            result.append(AppInfo.emptyAppInfo)
        }
        
        for page in 0..<totalPages {
            let pageOffset = page * rows * totalColumnsPerPage // Calculates the starting index (offset) of where a given page begins in the resulting array
            
            for column in 0..<columns {
                let columnIndex = 1 + column * 2 // Position of this data column: 1 (initial) + column * 2 (skipping blank columns)
                let initialColumnIndexInArray = pageOffset + columnIndex * rows // Calculates the starting index of this column in the result array
                
                for row in 0..<rows {
                    let resultIndex = initialColumnIndexInArray + row // Calculates the exact position in the resulting array where the element should be inserted
                    
                    if arrayIndex < filledApps.count {
                        result[resultIndex] = filledApps[arrayIndex]
                        arrayIndex += 1
                    }
                }
            }
        }
        
        return result
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                searchTextField
                Spacer()
            }
            .padding(.top, 8)
            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    AppGridView(
                        viewModel: viewModel,
                        rows: rows,
                        columns: columns,
                        apps: filteredApps,
                        geometry: geometry,
                        appWillClose: $appWillClose
                    )
                }
                .scrollTargetBehavior(.paging)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4))
    }
    
    private var searchTextField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white.opacity(0.6))
            
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    Text("Search apps...")
                }
                
                TextField("", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .foregroundStyle(.white.opacity(0.6))
            .font(.system(size: 16))
        }
        .padding(12)
        .frame(width: 400)
        .clipShape(.rect(cornerRadius: 12))
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
        
    }
}
