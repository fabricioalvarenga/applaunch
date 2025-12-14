//
//  ContentView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var appWillClose = false
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.7)

                LaunchpadView(appWillClose: $appWillClose)
        }
        .ignoresSafeArea()
        .onTapGesture {
            appWillClose = true
        }
        .onChange(of: appWillClose) { _, willClose in
            if willClose {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    NSApplication.shared.terminate(nil)
                }
            }
        }
        .onKeyPress(.escape) {
            appWillClose = true
            return .handled
        }
    }
}
