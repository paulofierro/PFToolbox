//
//   ViewModifyTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(SwiftUI)
import SwiftUI

@MainActor
struct ViewModifyTests {
    @Test func `modifier receives the original view`() {
        let text = Text("Hello")
        var received: Text?

        _ = text.modify { view -> Text in
            received = view
            return view
        }

        #expect(received == text)
    }

    @Test func `modifier is called exactly once`() {
        var callCount = 0

        _ = Text("Hello").modify { view -> Text in
            callCount += 1
            return view
        }

        #expect(callCount == 1)
    }

    @Test func `returns the modified view`() {
        let text = Text("Hello")

        let result = text.modify { $0.bold() }

        #expect(result as? Text == text.bold())
        #expect(result as? Text != text)
    }

    @Test func `returning the view unchanged is a passthrough`() {
        let text = Text("Hello")

        let result = text.modify { $0 }

        #expect(result as? Text == text)
    }

    @Test func `supports conditional branches`() {
        let text = Text("Hello")

        let applied = text.modify {
            if Bool(true) {
                $0.bold()
            } else {
                $0
            }
        }
        let skipped = text.modify {
            if Bool(false) {
                $0.bold()
            } else {
                $0
            }
        }

        #expect(applied is _ConditionalContent<Text, Text>)
        #expect(type(of: applied) == type(of: skipped))
    }
}
#endif
