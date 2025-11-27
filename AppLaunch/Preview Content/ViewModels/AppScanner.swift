//
//  AppScanner.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import AppKit

@Observable
class AppScanner {
    var apps: [AppInfo] = []
    
    private let applicationDirectories = [
        "/Applications",
        "/System/Applications",
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Applications").path
    ]
    
    static func getAppInfo(from url: URL) -> AppInfo? {
        guard let bundle = Bundle(url: url) else {
            return nil
        }
        
        let appName = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String
        ?? bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        ?? url.deletingLastPathComponent().lastPathComponent
        
        let appIcon = NSWorkspace.shared.icon(forFile: url.path)
        
        let bundleIdentifier = bundle.bundleIdentifier
        
        return AppInfo(
            name: appName,
            icon: appIcon,
            bundleURL: url,
            bundleIdentifier: bundleIdentifier
        )
    }
    
    func launchApp(app: AppInfo) {
        NSWorkspace.shared.open(app.bundleURL)
    }
    
}
