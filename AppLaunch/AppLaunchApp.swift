//
//  AppLaunchApp.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

@main
struct AppLaunchApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if let window = NSApplication.shared.windows.first {
                        window.styleMask = [.borderless, .fullSizeContentView]
                        window.isMovable = false
                        window.level = .floating
                        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
                        
                        if let screen = NSScreen.main {
                            window.setFrame(screen.frame, display: true)
                        }
                    }
                }
        }
        .windowResizability(.contentSize)
    }
}
