//
//   Endpoint.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
