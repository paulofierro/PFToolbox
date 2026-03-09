//
//   EncodableTests.swift
//   Copyright © Paulo Fierro. All rights reserved.
//

@testable import PFToolbox
import Testing

struct EncodableTests {
    struct MyStruct: Encodable {
        let name: String
    }

    @Test func jsonEncoding() throws {
        let value = MyStruct(name: "Paulo")
        let json = try value.toJSON()
        #expect(json == """
        {
          "name" : "Paulo"
        }
        """)
    }
}
