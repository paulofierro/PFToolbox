//
//  CancelToolbarItem.swift
//  PFToolbox
//
//  Created by Paulo Fierro on 19/04/2026.
//

#if canImport(SwiftUI)
import SwiftUI

public struct CancelToolbarItem: ToolbarContent {
    @Environment(\.dismiss) private var dismiss

    public init() {}

    public var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                dismiss()
            }
        }
    }
}
#endif
