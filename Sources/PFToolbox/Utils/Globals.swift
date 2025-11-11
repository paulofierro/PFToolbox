//
//  Globals.swift
//  PFToolbox
//
//  Created by Paulo Fierro on 11/11/25.
//

import Foundation

/// Returns true if currently showing a SwiftUI Preview
public func isShowingPreview() -> Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
