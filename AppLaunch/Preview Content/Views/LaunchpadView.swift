//
//  LaunchpadView.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct LaunchpadView: View {
    @FocusState private var isFocused
    @State private var viewModel = AppScanner()
    @Binding var appWillClose: Bool
    
    init(appWillClose: Binding<Bool> = Binding.constant(false)) {
        self._appWillClose = appWillClose
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                searchTextField
                Spacer()
            }
            .padding(.vertical, 32)
            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    AppGridView(
                        viewModel: viewModel,
                        geometry: geometry,
                        appWillClose: $appWillClose
                    )
                }
                .scrollTargetBehavior(.paging)
            }
        }
        .background(Color.blue.blur(radius: 200))
    }
    
    private var searchTextField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white.opacity(0.8))
            
            ZStack(alignment: .leading) {
                if viewModel.searchText.isEmpty {
                    Text("Search apps...")
                }
                
                TextField("", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
                    .focused($isFocused)
            }
            .foregroundStyle(.white.opacity(0.8))
            .font(.system(size: 16))
        }
        .padding(12)
        .frame(width: 400)
        .clipShape(.rect(cornerRadius: 12))
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .onAppear {
            isFocused = true
        }
    }
}
