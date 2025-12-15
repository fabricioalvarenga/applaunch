//
//  AppIcon.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import SwiftUI

struct AppIconView: View {
    @State private var isHovered = false
    
    private let app: AppInfo
    private let iconSize: CGFloat
    private let onTapGesture: () -> Void
    
    init(app: AppInfo, iconSize: CGFloat, onTapGesture: @escaping () -> Void) {
        self.app = app
        self.iconSize = iconSize
        self.onTapGesture = onTapGesture
    }
   
    var body: some View {
        VStack(spacing: 4) {
            if let name = app.name,
               let icon = app.icon {
                Image(nsImage: icon)
                    .resizable()
                    .frame(height: iconSize)
                    .scaleEffect(isHovered ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
                
                Text(name)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }
        }
        .frame(width: iconSize)
        .onTapGesture(perform: onTapGesture)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
