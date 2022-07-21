//
//  Dictionary.swift
//  
//
//  Created by Paulo Fierro on 31/5/22.
//

import Foundation

public extension Dictionary {
    /// Adds/overwrites all the values from the new dictionary
    mutating func merge(dict: [Key: Value]?) {
        guard let dict = dict else { return }
        
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
