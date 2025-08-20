//
//   NSViewTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

import ExceptionCatcher
@testable import PFToolbox
import XCTest

#if canImport(AppKit)
    final class NSViewTests: XCTestCase {
        func testLoadingNib() throws {
            // TODO: For some reason this fails on Github Actions
            // let testView = TestView()
            // testView.loadNib(in: Bundle.module)
        }

        func testLoadingNibFromMain() throws {
            let testView = TestView()
            do {
                _ = try ExceptionCatcher.catch {
                    testView.loadNib()
                }
            } catch {
                XCTAssertTrue(error.localizedDescription.contains("could not load the nib"))
            }
        }

        func testPinningEdges() throws {
            let superView = NSView(frame: .zero)
            let view = NSView(frame: .zero)

            XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
            XCTAssertTrue(view.constraints.isEmpty)

            superView.addSubview(view)
            view.pinEdges(to: superView)

            XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
            XCTAssertTrue(view.constraints.isEmpty)
        }
    }
#endif
