//
//  AppInfo.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import AppKit

struct AppInfo: Identifiable {
    let id: UUID
    let name: String
    let icon: NSImage
    let bundleURL: URL
    let bundleIdentifier: String?
    
    init(id: UUID = UUID(), name: String, icon: NSImage, bundleURL: URL, bundleIdentifier: String? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
        self.bundleURL = bundleURL
        self.bundleIdentifier = bundleIdentifier
    }
}
