//
//  Result.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public extension Result where Success == Void {
    // Source: https://github.com/apple/swift/pull/26471
    /// A success, without passing `Void` explicitly as the `Success` value.
    static var success: Result<Success, Failure> {
        .success(())
    }
}
