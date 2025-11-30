//
//  ContentView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = AppScanner()
    @State private var appClosed = true
    
    private let screenWidth = NSScreen.main?.visibleFrame.width ?? 800
    private let scrrenHeight = NSScreen.main?.visibleFrame.height ?? 800
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
                .opacity(0.5)
            
            if !appClosed {
                LaunchpadView(viewModel: viewModel, appClosed: $appClosed)
            }
        }
        .frame(width: screenWidth, height: scrrenHeight)
        .transition(
            AnyTransition.asymmetric(insertion: .launchpadOpen, removal: .launchpadClose)
        )
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 1.0)) {
                appClosed = true
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 1.0)) {
                appClosed = false
            }
        }
        .onChange(of: appClosed) { oldValue, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    NSApplication.shared.terminate(nil)
                }
            }
        }
    }
}
