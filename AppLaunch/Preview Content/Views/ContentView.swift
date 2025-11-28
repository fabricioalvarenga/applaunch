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
                        .asymmetric(
                            insertion: AnyTransition.opacity
                                .combined(with: .scale(scale: 1.1)),
                            removal: AnyTransition.opacity
                                .combined(with: .scale(scale: 0.9))
                        )
                    )
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.1, dampingFraction: 1.0)) {
                appeared = false
            }
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                NSApplication.shared.terminate(nil)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.35, dampingFraction: 1.0)) {
                appeared = true
            }
        }
    }
}
