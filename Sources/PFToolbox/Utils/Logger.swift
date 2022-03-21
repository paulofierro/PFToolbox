//
//  Logger.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public struct Logger {
    
    public init() {}
    
    public func verbose(_ message: String) {
        print("🔸 \(message)")
    }
    
    public func debug(_ message: String) {
        print("🔹🔹🔹 \(message)")
    }
    
    public func info(_ message: String) {
        print("✳️✳️✳️ \(message)")
    }
    
    public func warn(_ message: String) {
        print("⚠️⚠️⚠️ \(message)")
    }

    public func error(_ message: String) {
        print("‼️‼️‼️ \(message)")
    }
}

public let log = Logger()
