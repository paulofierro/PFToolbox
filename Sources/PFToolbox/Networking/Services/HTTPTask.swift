//
//   HTTPTask.swift
//   Copyright © 2022 Paulo Fierro. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestWithJSONPayload(_ payload: Payload?)
}
