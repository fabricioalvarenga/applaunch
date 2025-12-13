//
//  LoadWallpaper.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 13/12/25.
//

import AppKit
import SwiftUI

class Wallpaper {
    static func load() -> Image? {
        guard let screen = NSScreen.main,
              let imageURL = NSWorkspace.shared.desktopImageURL(for: screen),
              let image = NSImage(contentsOf: imageURL) else {
                return nil
        }
        
        return Image(nsImage: image)
    }
}
