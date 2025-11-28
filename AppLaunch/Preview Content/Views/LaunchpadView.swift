//
//  LaunchpadView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct LaunchpadView: View {
    @State private var searchText = ""
    
    private var apps: [AppInfo]
    private var columns: Int
    private var rows: Int
    
    init(apps: [AppInfo], columns: Int = 7, rows: Int = 5) {
        self.apps = apps
        self.columns = columns
        self.rows = rows
    }
    
    private var appsPerPage: Int {
        columns * rows
    }
    
    // Filtra os apps com base no campo de pesquisa
    // Adiciona uma coluna de apps em branco no iníco do array
    // Adiciona uma coluna de apps em branco entre cada coluna do array
    // Adiciona a quantidade de apps em branco necessário para que ...
    // ... cada página fique com a quantidade uniforme de apps
    private var filteredApps: [AppInfo] {
        var filledApps: [AppInfo] = []
        
        // Filtra os apps com base no campo de pesquisa
        if searchText.isEmpty {
            filledApps = apps
        } else {
            filledApps = apps.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Adiciona uma coluna de apps em branco no início do array e
        // adciona uma coluna de apps em branco entre cada coluna do array
        var position = 0
        var shift = 0
        while position < filledApps.count {
            filledApps.insert(contentsOf: AppInfo.createEmptyAppsInfo(count: rows), at: position)
            position += rows * 2
            
            let remainder = (position + shift) % ((appsPerPage * 2) - rows)
            if remainder == rows {
                filledApps.insert(contentsOf: AppInfo.createEmptyAppsInfo(count: rows), at: position)
                position += rows
                shift += rows
            }
        }
        
        // Adiciona a quantidade de apps em branco necessário para que
        // cada página fique com a quantidade uniforme de apps
        let count = filledApps.count
        let remainder = count % (appsPerPage * 2 + rows)
        let elementsToAdd = (appsPerPage * 2) - remainder
        
        filledApps.append(contentsOf: AppInfo.createEmptyAppsInfo(count: elementsToAdd))
        
        return filledApps
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
                        rows: rows,
                        columns: columns,
                        apps: filteredApps,
                        geometry: geometry
                    )
                }
                .scrollTargetBehavior(.paging)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            NSApplication.shared.terminate(nil)
        }
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
