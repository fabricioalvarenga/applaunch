//
//  ContentView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 22/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = AppScanner()
    @State private var appeared = false
    
    var body: some View {
        ZStack {
            Color.blue
                .opacity(0.5)
                .ignoresSafeArea()
            
            if appeared {
                LaunchpadView(viewModel: viewModel)
                    .transition(
                        AnyTransition.asymmetric(insertion: .launchpadOpen, removal: .launchpadClose)
                    )
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 1.0)) {
                appeared = false
            }
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                NSApplication.shared.terminate(nil)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 1.0)) {
                appeared = true
            }
        }
    }
}
