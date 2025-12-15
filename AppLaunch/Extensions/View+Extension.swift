//
//  View+Extension.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 15/12/25.
//

import SwiftUI

extension View {
    func onScrollViewOffsetChanged(_ action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minX)
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                            action(value)
                        }
                }
            )
        
    }
}
