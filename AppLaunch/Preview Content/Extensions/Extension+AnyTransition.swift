//
//  Extension+AnyTransition.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 27/11/25.
//

import SwiftUI

extension AnyTransition {
    static var launchpadOpen: AnyTransition {
        AnyTransition.opacity
            .combined(with: scale(scale: 1.1))
    }
    
    static var launchpadClose: AnyTransition {
        AnyTransition.opacity
            .combined(with: scale(scale: 0.9))
    }
}
