//
//  ContentView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
    }
}

struct AppItem: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
}

struct ContentView: View {
    @State private var isLaunchpadOpen = false
    @State private var searchText = ""
    @State private var currentPage = 0
    
    let apps: [AppItem] = [
        AppItem(name: "Safari", icon: "safari", color: .blue),
        AppItem(name: "Mail", icon: "envelope.fill", color: .blue),
        AppItem(name: "Photos", icon: "photo.on.rectangle", color: .pink),
        AppItem(name: "Messages", icon: "message.fill", color: .green),
        AppItem(name: "Calendar", icon: "calendar", color: .red),
        AppItem(name: "Notes", icon: "note.text", color: .yellow),
        AppItem(name: "Reminders", icon: "checklist", color: .orange),
        AppItem(name: "Music", icon: "music.note", color: .pink),
        AppItem(name: "Podcasts", icon: "podcast.fill", color: .purple),
        AppItem(name: "TV", icon: "tv.fill", color: .black),
        AppItem(name: "Books", icon: "book.fill", color: .orange),
        AppItem(name: "App Store", icon: "app.gift.fill", color: .blue),
        AppItem(name: "Settings", icon: "gearshape.fill", color: .gray),
        AppItem(name: "Maps", icon: "map.fill", color: .green),
        AppItem(name: "FaceTime", icon: "video.fill", color: .green),
        AppItem(name: "Contacts", icon: "person.crop.circle.fill", color: .gray),
        AppItem(name: "Calculator", icon: "plus.forwardslash.minus", color: .gray),
        AppItem(name: "Weather", icon: "cloud.sun.fill", color: .cyan),
        AppItem(name: "Clock", icon: "clock.fill", color: .gray),
        AppItem(name: "Preview", icon: "doc.text.image", color: .indigo),
        AppItem(name: "Finder", icon: "folder.fill", color: .blue),
        AppItem(name: "System Preferences", icon: "switch.2", color: .gray),
        AppItem(name: "QuickTime", icon: "play.rectangle.fill", color: .gray),
        AppItem(name: "Safari", icon: "safari", color: .blue),
        AppItem(name: "Mail", icon: "envelope.fill", color: .blue),
        AppItem(name: "Photos", icon: "photo.on.rectangle", color: .pink),
        AppItem(name: "Messages", icon: "message.fill", color: .green),
        AppItem(name: "Calendar", icon: "calendar", color: .red),
        AppItem(name: "Notes", icon: "note.text", color: .yellow),
        AppItem(name: "Reminders", icon: "checklist", color: .orange),
        AppItem(name: "Music", icon: "music.note", color: .pink),
        AppItem(name: "Podcasts", icon: "podcast.fill", color: .purple),
        AppItem(name: "TV", icon: "tv.fill", color: .black),
        AppItem(name: "Books", icon: "book.fill", color: .orange),
        AppItem(name: "App Store", icon: "app.gift.fill", color: .blue),
        AppItem(name: "Settings", icon: "gearshape.fill", color: .gray),
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color(red: 0.3, green: 0.2, blue: 0.4),
                    Color(red: 0.5, green: 0.3, blue: 0.5)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if !isLaunchpadOpen {
                VStack {
                    Spacer()
                    
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isLaunchpadOpen = true
                        }
                    } label: {
                        Image(systemName: "square.grid.3x3")
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 128)
                }
            }
            
            if isLaunchpadOpen {
                LaunchpadView(
                    apps: apps,
                    isOpen: $isLaunchpadOpen,
                    searchText: $searchText,
                    currentPage: $currentPage
                )
                .transition(.opacity)
            }
        }
    }
}

struct LaunchpadView: View {
    let apps: [AppItem]
    
    @Binding var isOpen: Bool
    @Binding var searchText: String
    @Binding var currentPage: Int
    
    let columns = 7
    let rows = 5
    
    var appsPerPage: Int {
        columns * rows
    }
    
    var filteredApps: [AppItem] {
        if searchText.isEmpty {
            return apps
        } else {
            return apps.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var totalPages: Int {
        max(1, Int(ceil(Double(filteredApps.count) / Double(appsPerPage))))
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .background(.ultraThinMaterial)
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white.opacity(0.6))
                        
                        TextField("Buscar apps...", text: $searchText)
                            .textFieldStyle(.plain)
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(12)
                    .frame(width: 400)
                    .clipShape(.rect(cornerRadius: 12))
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    
                    Button {
                        closeLaunchPad()
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
                    
                    Spacer()
                }
                .padding(.horizontal, 64)
                .padding(.top, 64)
                
                GeometryReader { geometry in
                    let iconDimension = (geometry.size.width / CGFloat(columns * 2 + 1)) * 0.8
                    let horizontalSpacing = (geometry.size.width - (iconDimension * CGFloat(columns))) / CGFloat(columns + 1)
                    let verticalSpacing = (geometry.size.height - (iconDimension * CGFloat(rows))) / CGFloat(rows + 1)
                    let gridRows = Array(repeating: GridItem(.fixed(iconDimension), spacing: verticalSpacing * 0.8), count: rows)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            LazyHGrid(rows: gridRows, spacing: horizontalSpacing) {
                                ForEach(filteredApps) { app in
                                    AppIconView(app: app, size: iconDimension)
                                        .onTapGesture {
                                            handleAppClick(app)
                                        }
                                }
                            }
                            .padding(.horizontal, horizontalSpacing)
                        }
                    }
                    .padding(.top, -verticalSpacing)
                }
                    
                if totalPages > 1 && searchText.isEmpty {
                    HStack(spacing: 8) {
                        ForEach(0..<totalPages, id: \.self) { page in
                            Circle()
                                .fill(currentPage == page ? Color.white : Color.white.opacity(0.4))
                                .frame(width: currentPage == page ? 8 : 6, height: 6)
                                .animation(.spring(response: 0.3), value: currentPage)
                                .onTapGesture {
                                    withAnimation {
                                        currentPage = page
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 36)
                }
            }
        }
        .onTapGesture {
            closeLaunchPad()
        }
        .onAppear {
            currentPage = 0
        }
    }
    
    func getAppsForPage(_ page: Int) -> [AppItem] {
        let start = page * appsPerPage
        let end = min(start + appsPerPage, filteredApps.count)
        return Array(filteredApps[start..<end])
    }
    
    func handleAppClick(_ app: AppItem) {
        let alert = NSAlert()
        alert.messageText = "Abrindo \(app.name)"
        alert.informativeText = "App clicado: \(app.name)"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    func closeLaunchPad() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            isOpen = false
            searchText = ""
            currentPage = 0
        }
    }
}

struct AppIconView: View {
    let app: AppItem
    let size: CGFloat
    
    @State private var isHovered = false
    @State private var appeared = false
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: size * 0.225)
                    .fill(
                        LinearGradient(
                            colors: [app.color.opacity(0.8), app.color],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
//                    .shadow(color: app.color.opacity(0.5), radius: isHovered ? 20 : 10)
                
                Image(systemName: app.icon)
                    .font(.system(size: size * 0.45))
                    .foregroundStyle(.white)
            }
            .frame(width: size, height: size)
            .overlay(
                RoundedRectangle(cornerRadius: size * 0.225)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            .scaleEffect(isHovered ? 1.1 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            
            Text(app.name)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .lineLimit(1)
                .frame(width: size)
        }
        .scaleEffect(appeared ? 1 : 0.5)
        .opacity(appeared ? 1 : 0)
        .onAppear {
//            withAnimation(.spring(response: 0.4, dampingFraction: 0.7).delay(Double.random(in: 0...0.2))) {
                appeared = true
//            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
}

#Preview {
    ContentView()
}
