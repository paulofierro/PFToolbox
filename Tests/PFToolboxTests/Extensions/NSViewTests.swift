//
//   NSViewTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import AppKit
import ExceptionCatcher
@testable import PFToolbox
import Testing

#if canImport(AppKit)
    struct NSViewTests {
        @Test func loadingNib() {
            // TODO: For some reason this fails on Github Actions
            // let testView = TestView()
            // testView.loadNib(in: Bundle.module)
        }

        @Test func loadingNibFromMain() throws {
            let testView = TestView()
            do {
                _ = try ExceptionCatcher.catch {
                    testView.loadNib()
                }
            } catch {
                #expect(error.localizedDescription.contains("could not load the nib"))
            }
        }

        @Test func pinningEdges() {
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
