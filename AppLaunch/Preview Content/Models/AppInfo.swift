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
}
