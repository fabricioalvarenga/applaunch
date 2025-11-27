//
//  AppIcon.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppIconView: View {
    @State private var isHovered = false
    @State private var appeared = false
    
    private let app: AppItem
    private let size: CGFloat
    
    init(app: AppItem, size: CGFloat) {
        self.app = app
        self.size = size
    }
   
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: size * 0.225)
                    .fill(
                        LinearGradient(
                            colors: [app.color.opacity(0.8), app.color],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                if !app.icon.isEmpty {
                    Image(systemName: app.icon)
                        .font(.system(size: size * 0.45))
                        .foregroundStyle(.white)
                }
            }
            .frame(width: size, height: size)
            .overlay(
                RoundedRectangle(cornerRadius: size * 0.225)
                    .stroke(app.color == .clear ? Color.clear : Color.white.opacity(0.1), lineWidth: 1)
            )
            .scaleEffect(isHovered ? 1.1 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            
            Text(app.name)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .lineLimit(1)
                .frame(width: size)
        }
        .scaleEffect(appeared ? 1 : 0.5)
        .opacity(appeared ? 1 : 0)
        .onAppear {
            appeared = true
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
