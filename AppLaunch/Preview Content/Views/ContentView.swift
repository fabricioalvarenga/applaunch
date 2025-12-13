//
//  ContentView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var appWillClose = true
    
    private let screenWidth = NSScreen.main?.visibleFrame.width ?? 800
    private let scrrenHeight = NSScreen.main?.visibleFrame.height ?? 800
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.7)

            if !appWillClose {
                LaunchpadView(appWillClose: $appWillClose)
                    .transition(
                        AnyTransition.asymmetric(insertion: .launchpadOpen, removal: .launchpadClose)
                    )
                
            }
        }
        .frame(width: screenWidth, height: scrrenHeight)
        .onTapGesture {
            withAnimation(.spring(response: 0.1, dampingFraction: 1.0)) {
                appWillClose = true
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 1.0)) {
                appWillClose = false
            }
        }
        .onChange(of: appWillClose) { oldValue, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
                    NSApplication.shared.terminate(nil)
                }
            }
        }
    }
}
