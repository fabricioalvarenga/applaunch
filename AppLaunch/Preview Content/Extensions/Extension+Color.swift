//
//  WindowAccessor.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 13/12/25.
//

import SwiftUI
import AppKit

extension Color {
    static var transparent: some View {
        MakeViewTransparent()
    }
}

struct MakeViewTransparent: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                window.isOpaque = false
                window.backgroundColor = .clear
                window.titlebarAppearsTransparent = true
            }
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
