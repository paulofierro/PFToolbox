//
//  HTTPTask.swift
//  
//
//  Created by Paulo Fierro on 31/5/22.
//

import Foundation

public enum HTTPTask {
    case request
    case requestWithJSONPayload(_ payload: Payload?)
}
