//
//   Endpoint.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var urlParameters: Parameters { get }
    var task: HTTPTask { get }
}
