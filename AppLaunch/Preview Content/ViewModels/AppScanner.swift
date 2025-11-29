//
//  AppScanner.swift
//  AppLaunch
//
//  Created by FABRICIO ALVARENGA on 26/11/25.
//

import AppKit
import CoreServices

@Observable
class AppScanner {
    var apps: [AppInfo] = []
    
    private let fileManager = FileManager.default
    
    private let applicationDirectories = [
        "/Applications",
        "/System/Applications",
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Applications").path
    ]
    
    init() {
        scanApplications()
    }
    
    private func scanApplications() {
        var scannedApps: [AppInfo] = []
        
        for directory in applicationDirectories {
            let apps = getApplications(from: directory)
            scannedApps.append(contentsOf: apps)
        }
        
        scannedApps.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        
        DispatchQueue.main.async {
            self.apps = scannedApps
        }
    }
    
    
    private func getApplications(from directory: String) -> [AppInfo] {
        var applications: [AppInfo] = []
        let fileManager = FileManager.default
        
        guard let contents = try? fileManager.contentsOfDirectory(atPath: directory) else {
            return applications
        }
        
        for item in contents {
            let fullPath = (directory as NSString).appendingPathComponent(item)
            
            if item.hasSuffix(".app") {
                let appURL = URL(fileURLWithPath: fullPath)
                
                if let appInfo = getAppInfo(from: appURL) {
                    applications.append(appInfo)
                }
            }
        }
        
        return applications
    }
    
    private func getAppInfo(from url: URL) -> AppInfo? {
        guard let bundle = Bundle(url: url) else {
            return nil
        }
        
        let bundleIdentifier = bundle.bundleIdentifier
        let appIcon = NSWorkspace.shared.icon(forFile: url.path)
        var appName = spotlightDisplayName(for: url)
        
        if appName == nil {
            appName = bundle.localizedInfoDictionary?["CFBundleDisplayName"] as? String
            ?? bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
            ?? bundle.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? url.deletingLastPathComponent().lastPathComponent
        }
        
        return AppInfo(
            name: appName ?? "Unknown App",
            icon: appIcon,
            bundleURL: url,
            bundleIdentifier: bundleIdentifier
        )
    }
    
    func spotlightDisplayName(for url: URL) -> String? {
        guard let item = MDItemCreateWithURL(kCFAllocatorDefault, url as CFURL),
              let name = MDItemCopyAttribute(item, kMDItemDisplayName) as? String else {
            return nil
        }
        
        return name
    }
   
    func launchApp(_ app: AppInfo) {
        guard let bundleURL = app.bundleURL else {
            return
        }
        
        NSWorkspace.shared.open(bundleURL)
    }
    
}
