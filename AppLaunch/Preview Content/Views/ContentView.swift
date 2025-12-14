//
//  ContentView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var isFocused: Bool
    @State private var appWillClose = false
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.7)

                LaunchpadView(appWillClose: $appWillClose)
        }
        .ignoresSafeArea()
        .focusable()
        .focused($isFocused)
        .onTapGesture {
            appWillClose = true
        }
        .onAppear {
            isFocused = true
        }
        .onChange(of: appWillClose) { oldValue, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
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
