//
//  AppDelegate.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

// AppDelegate.swift
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    // Mude o tipo para NSWindow se você descartou a subclasse
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Use NSWindow em vez da subclasse customizada
        window = NSWindow(
            contentRect: .zero,
            styleMask: [.docModalWindow], // Seu estilo de trabalho
            backing: .buffered,
            defer: false
        )
        
        // ... (Seu código de frame e outras configurações)
        if let screen = NSScreen.main {
            window.setFrame(screen.frame, display: true)
        }
        
        window.isMovable = false
        window.level = .floating // O .docModalWindow pode já ter definido um nível alto
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        // ... (Hosting View)
        let hostingView = NSHostingView(rootView: ContentView())
        window.contentView = hostingView
        
        // 🚨 Ação Crítica: Forçar a janela a se tornar a Key Window
        // O .makeKeyAndOrderFront chama implicitamente canBecomeKeyWindow.
        // O aviso ocorre porque ele retorna NO antes de ser Key.
        window.makeKeyAndOrderFront(nil)
        
        // Solução de baixo nível (se o aviso persistir):
        // Você pode ter que garantir que o window.contentView possa ser o primeiro respondedor.
        if let contentView = window.contentView {
            window.makeFirstResponder(contentView)
        }
    }
    
    // ...
}
