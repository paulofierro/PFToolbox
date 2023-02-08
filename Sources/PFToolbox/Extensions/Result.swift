//
//   Result.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public extension Result where Success == Void {
    // Source: https://github.com/apple/swift/pull/26471
    /// A success, without passing `Void` explicitly as the `Success` value.
    static var success: Result<Success, Failure> {
        .success(())
    }
}
