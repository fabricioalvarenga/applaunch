//
//  AppLaunchApp.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

@main
struct AppLaunchApp: App {
    private let visibleFrameWidth = NSScreen.main!.visibleFrame.width
    private let visibleFrameHeight = NSScreen.main!.visibleFrame.height
    private let menubarHeight = NSScreen.main!.frame.height -
    NSScreen.main!.visibleFrame.height -
    NSScreen.main!.visibleFrame.origin.y
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: visibleFrameWidth, height: visibleFrameHeight + menubarHeight)
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
