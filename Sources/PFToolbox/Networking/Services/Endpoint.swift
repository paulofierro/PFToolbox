//
//  EndPoint.swift
//  
//
//  Created by Paulo Fierro.
//

import Foundation

public protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
