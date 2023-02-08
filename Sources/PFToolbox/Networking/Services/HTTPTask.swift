//
//   HTTPTask.swift
//   Copyright © 2023 Paulo Fierro. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestWithJSONPayload(_ payload: Payload?)
}
