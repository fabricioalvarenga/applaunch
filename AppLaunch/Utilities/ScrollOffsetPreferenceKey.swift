//
//  ScrollOffsetPreferenceKey.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 15/12/25.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
