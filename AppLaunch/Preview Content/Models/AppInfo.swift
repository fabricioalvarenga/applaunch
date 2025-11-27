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
    let icon: NSImage?
    let bundleURL: URL?
    let bundleIdentifier: String?
    
    init(id: UUID = UUID(), name: String, icon: NSImage? = nil, bundleURL: URL? = nil, bundleIdentifier: String? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
        self.bundleURL = bundleURL
        self.bundleIdentifier = bundleIdentifier
    }
    
    static var emptyAppInfo: Self {
        .init(name: "")
    }
    
    static func createEmptyAppsInfo(count: Int) -> [Self] {
        var emptyApp: [Self] = []
        for _ in 0..<count { emptyApp.append(Self.emptyAppInfo) }
        return emptyApp
    }
}
