//
//  QueryTests.swift
//  GraphQLicious
//
//  Created by Felix Dietz on 01/04/16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

import XCTest
@testable import GraphQLicious

class QueryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
  func testEmptyRequest() {
    let output = "{}"
    let query = Query(readingRequest: ReadingRequest(
      name: "",
      arguments: [
      ],
      fields: [
      ]
      )
    )
    XCTAssertEqual(query.create(), output, "Output doesn't match request")
  }
  
  func testRequestWithEmptyName() {
    let output = "{(ids: 153082687){id,headline}}"
    let query = Query(readingRequest: ReadingRequest(
      name: "",
      arguments: [
        Argument(key: "ids", value: 153082687)
      ],
      fields: [
        "id",
        "headline",
      ]
      )
    )
    XCTAssertEqual(query.create(), output, "Output doesn't match request")
  }
  
  func testRequestWithEmptyArguments() {
    let output = "{content{id,headline}}"
    let query = Query(readingRequest: ReadingRequest(
      name: "content",
      arguments: [
      ],
      fields: [
        "id",
        "headline",
      ]
      )
    )
    XCTAssertEqual(query.create(), output, "Output doesn't match request")
  }
  
  func testRequestWithEmptyFields() {
    let output = "{content(ids: 153082687)}"
    let query = Query(readingRequest: ReadingRequest(
      name: "content",
      arguments: [
        Argument(key: "ids", value: 153082687)
      ],
      fields: [
      ]
      )
    )
    XCTAssertEqual(query.create(), output, "Output doesn't match request")
  }
  
  func testRequestWithAlias() {
    let output = "{test:content(ids: 153082687){id,headline}}"
    let query = Query(readingRequest: ReadingRequest(
      withAlias: "test",
      name: "content",
      arguments: [
        Argument(key: "ids", value: 153082687)
      ],
      fields: [
        "id",
        "headline",
      ]
    ))
    XCTAssertEqual(query.create(), output, "Output doesn't match request")
  }
  
  func testComplexRequest() {
    let output = "query ComplexQuery {content(ids: 153082687){id,headline,image(role: \"opener\"){id,homeSection{displayName},url(ratio: 1.777,size: 200)}}}"
    let query = Query(withAlias: "ComplexQuery", readingRequest: ReadingRequest(
      name: "content",
      arguments: [
        Argument(key: "ids", value: 153082687)
      ],
      fields: [
        "id",
        "headline",
        ReadingRequest(
          name: "image",
          arguments: [
            Argument(key: "role", value: "opener")
          ],
          fields: [
            "id",
            ReadingRequest(
              name: "homeSection",
              arguments: [],
              fields: [
                "displayName"
              ]
            ),
            ReadingRequest(
              name: "url",
              arguments: [
                Argument(key: "ratio", value: 1.777),
                Argument(key: "size", value: 200)
              ]
            ),
          ]
        )
      ]
      )
    )
    
    XCTAssertEqual(query.create(), output, "Output doesn't match request")
  }
}