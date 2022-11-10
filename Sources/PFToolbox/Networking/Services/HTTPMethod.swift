//
//   HTTPMethod.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    var isUploadMethod: Bool {
        switch self {
        case .post, .put, .patch:
            return true
        default:
            return false
        }
    }
}
