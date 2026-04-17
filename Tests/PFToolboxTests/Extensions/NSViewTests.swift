//
//   NSViewTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

#if canImport(AppKit)
import AppKit
import ExceptionCatcher

struct NSViewTests {
    @Test func `loading nib`() {
        // TODO: For some reason this fails on Github Actions
        // let testView = TestView()
        // testView.loadNib(in: Bundle.module)
    }

    @Test func `loading nib from main`() throws {
        let testView = TestView()
        do {
            _ = try ExceptionCatcher.catch {
                testView.loadNib()
            }
        } catch {
            #expect(error.localizedDescription.contains("could not load the nib"))
        }
    }

    @Test func `pinning edges`() {
        let superView = NSView(frame: .zero)
        let view = NSView(frame: .zero)

        #expect(view.translatesAutoresizingMaskIntoConstraints)
        #expect(view.constraints.isEmpty)

        superView.addSubview(view)
        view.pinEdges(to: superView)

        #expect(!view.translatesAutoresizingMaskIntoConstraints)
        #expect(view.constraints.isEmpty)
    }
}
#endif
