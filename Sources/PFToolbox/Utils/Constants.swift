//
//   Constants.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation
#if canImport(UIKit)
    import UIKit
#endif

public enum Constants {
    /// The app's version
    public static let versionNumber = "\(Bundle.main.versionNumber, default: "?")"

    public static let versionText = "Version \(versionNumber)"

    #if canImport(UIKit)
        /// The URL to the app's settings page
        public static let settingsUrl = URL.from(string: UIApplication.openSettingsURLString)
    #endif

    /// The URL to the company website
    public static let companyUrl = URL.from(string: "https://jadehopper.com")
}
