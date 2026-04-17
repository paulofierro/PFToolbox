//
//   Device.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public enum Device {
    public static func isPhone() -> Bool {
        #if canImport(UIKit)
        UIDevice.current.userInterfaceIdiom == .phone
        #else
        false
        #endif
    }

    public static func isIpad() -> Bool {
        #if canImport(UIKit)
        UIDevice.current.userInterfaceIdiom == .pad
        #else
        false
        #endif
    }

    public static func isTV() -> Bool {
        #if canImport(UIKit)
        UIDevice.current.userInterfaceIdiom == .tv
        #else
        false
        #endif
    }

    public static func isCarPlay() -> Bool {
        #if canImport(UIKit)
        UIDevice.current.userInterfaceIdiom == .carPlay
        #else
        false
        #endif
    }

    public static func isMac() -> Bool {
        #if canImport(UIKit)
        UIDevice.current.userInterfaceIdiom == .mac
        #elseif canImport(AppKit)
        true
        #else
        false
        #endif
    }

    public static func isVision() -> Bool {
        #if canImport(UIKit)
        UIDevice.current.userInterfaceIdiom == .vision
        #else
        false
        #endif
    }
}
