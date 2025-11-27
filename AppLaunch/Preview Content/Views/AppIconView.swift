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
    
    init(app: AppInfo, iconSize: CGFloat) {
        self.app = app
        self.iconSize = iconSize
    }
   
    var body: some View {
        VStack(spacing: 4) {
            if let icon = app.icon {
                Image(nsImage: icon)
                    .resizable()
                    .frame(height: iconSize)
                    .scaleEffect(isHovered ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isHovered)
            } else {
                EmptyView()
                    .frame(height: iconSize)
            }
            
            Text(app.name)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white)
                .lineLimit(1)
        }
        .frame(width: iconSize)
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
