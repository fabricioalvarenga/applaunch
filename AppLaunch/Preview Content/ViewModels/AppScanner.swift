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
    var searchText: String = ""
    let rows = 5
    let columns = 7
    private var scannedApps: [AppInfo] = []
    private let fileManager = FileManager.default
   
    private let applicationDirectories = [
        "/Applications",
        "/System/Applications",
        FileManager.default.homeDirectoryForCurrentUser.appending(path: "Applications").path
    ]
    
    init() {
        scanApplications()
    }
    
    private var filteredApps: [AppInfo] {
        var result: [AppInfo] = []
        
         if searchText.isEmpty {
            result = scannedApps
        } else {
            result = scannedApps.filter { app in
                guard let name = app.name else { return false }
                return name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    private var totalPages: Int {
        let elementsPerPage = rows * columns
        return (filteredApps.count + elementsPerPage - 1) / elementsPerPage
    }
    
    // Adds a blank app column at the beginning of the array
    // Adds a blank app column between each column of the array
    // Adds the necessary number of blank apps so that each page has a uniform number of apps
    var apps: [AppInfo] {
        let totalColumnsPerPage = 2 * columns + 1
        let totalElements = totalPages * rows * totalColumnsPerPage
        
        var arrayIndex = 0
        var result: [AppInfo] = []

        // Fill result array with blank elements
        for _ in 0..<totalElements {
            result.append(AppInfo.emptyAppInfo)
        }
        
        for page in 0..<totalPages {
            let pageOffset = page * rows * totalColumnsPerPage // Calculates the starting index (offset) of where a given page begins in the resulting array
            
            for column in 0..<columns {
                let columnIndex = 1 + column * 2 // Position of this data column: 1 (initial) + column * 2 (skipping blank columns)
                let initialColumnIndexInArray = pageOffset + columnIndex * rows // Calculates the starting index of this column in the result array
                
                for row in 0..<rows {
                    let resultIndex = initialColumnIndexInArray + row // Calculates the exact position in the resulting array where the element should be inserted
                    
                    if arrayIndex < filteredApps.count {
                        result[resultIndex] = filteredApps[arrayIndex]
                        arrayIndex += 1
                    }
                }
            }
        }
        
        return result
    }
 
    private func scanApplications() {
        var scannedApps: [AppInfo] = []
        
        for directory in applicationDirectories {
            let apps = getApplications(from: directory)
            scannedApps.append(contentsOf: apps)
        }
        
        scannedApps.sort { first, second in
            guard let firstName = first.name,
                  let secondName = second.name else { return false }
            
            return firstName.localizedCaseInsensitiveCompare(secondName) == .orderedAscending
        }
        
        DispatchQueue.main.async {
            self.scannedApps = scannedApps
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
            appName = bundleDisplayName(for: bundle, and: url)
        }
        
        return AppInfo(
            name: appName ?? "Unknown App",
            icon: appIcon,
            bundleURL: url,
            bundleIdentifier: bundleIdentifier
        )
    }
    
    func bundleDisplayName(for bundle: Bundle, and url: URL) -> String? {
        let appName = bundle.localizedInfoDictionary?["CFBundleDisplayName"] as? String
        ?? bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        ?? bundle.object(forInfoDictionaryKey: "CFBundleName") as? String
        ?? url.deletingLastPathComponent().lastPathComponent
            
        return appName
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
        
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 0.1) {
            NSWorkspace.shared.open(bundleURL)
        }
    }
    
}
