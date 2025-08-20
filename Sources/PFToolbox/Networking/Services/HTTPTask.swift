//
//   HTTPTask.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestWithJSONPayload(_ payload: Payload?)
    case requestWithForm(_ params: [String: String])
}
