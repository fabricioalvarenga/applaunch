//
//  AppLaunchApp.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

@main
struct AppLaunchApp: App {
    private let screenWidth = NSScreen.main!.visibleFrame.width
    private let scrrenHeight = NSScreen.main!.visibleFrame.height
 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: screenWidth, height: scrrenHeight)
                .background(Color.transparent)
                .onAppear {
                    NSApp.presentationOptions = [.hideDock]
                    
                    if let window = NSApplication.shared.windows.first {
                        window.standardWindowButton(.closeButton)?.isHidden = true
                        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
                        window.standardWindowButton(.zoomButton)?.isHidden = true
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
