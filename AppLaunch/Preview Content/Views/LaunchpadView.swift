//
//  LaunchpadView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct LaunchpadView: View {
    @State private var searchText = ""

    private var apps = Apps.items
    private var columns = 7
    private var rows = 5
    
    init(apps: [AppItem] = [], columns: Int = 7, rows: Int = 5) {
        self.apps = apps
        self.columns = columns
        self.rows = rows
    }
    
    private var appsPerPage: Int {
        columns * rows
    }
    
    private var filteredApps: [AppItem] {
        var filledApps: [AppItem] = []
        
        if searchText.isEmpty {
            filledApps = apps
        } else {
            filledApps = apps.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        let count = filledApps.count
        let remainder = count % (appsPerPage)
        let elementsToAdd = appsPerPage - remainder
        
        var fillerElements: [AppItem] = []
        
        for _ in 0..<(elementsToAdd - 1) {
            fillerElements.append(AppItem(id: UUID(), name: "", icon: "", color: .clear))
        }
        
        filledApps.append(contentsOf: fillerElements)
        
        return filledApps
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                searchTextField
                closeAppButton
                Spacer()
            }
            .padding(.horizontal, 64)
            .padding(.top, 64)
            
            GeometryReader { geometry in
                let iconSize = (geometry.size.width / CGFloat(columns * 2 + 1)) * 0.8
                let horizontalSpacing = (geometry.size.width - (iconSize * CGFloat(columns))) / CGFloat(columns + 1)
                let verticalSpacing = (geometry.size.height - (iconSize * CGFloat(rows))) / CGFloat(rows + 1)
                let gridRows = Array(repeating: GridItem(.fixed(iconSize), spacing: verticalSpacing * 0.8), count: rows)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    AppGridView(
                        gridRows: gridRows,
                        apps: filteredApps,
                        horizontalSpacing: horizontalSpacing,
                        iconSize: iconSize
                    )
                }
                .padding(.top, -verticalSpacing)
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
    
    private var closeAppButton: some View {
        Button {
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white.opacity(0.6))
                .frame(width: 40, height: 40)
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        
    }
    
}
