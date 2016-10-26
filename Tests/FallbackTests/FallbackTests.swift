import XCTest
@testable import Fallback

struct TestError<T>: Error {
  let value: T
  init(_ value: T) {
    self.value = value
  }
}

final class FallbackTests: XCTestCase {

  static var allTests: [(String, (FallbackTests) -> () throws -> Void)] {
    return [
      ("testFallback_throws", testFallback_throws),
      ("testFallback", testFallback),
    ]
  }

  func get<T>(_ value: T, throws: Bool) throws -> T {
    if `throws` {
      throw TestError(value)
    }
    return value
  }

  func testFallback_throws() {
    XCTAssertThrowsError(
      try fallback(
        try get("devxoul1", throws: true)
      )
    )
    XCTAssertThrowsError(
      try fallback(
        try get("devxoul1", throws: true),
        try get("devxoul2", throws: true)
      )
    )
    XCTAssertThrowsError(
      try fallback(
        try get("devxoul1", throws: true),
        try get("devxoul2", throws: true),
        try get("devxoul3", throws: true)
      )
    )
  }

  func testFallback() {
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false)
      ),
      "devxoul1"
    )

    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false),
        try get("devxoul2", throws: false)
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false),
        try get("devxoul2", throws: true)
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: true),
        try get("devxoul2", throws: false)
      ),
      "devxoul2"
    )

    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false),
        try get("devxoul2", throws: false),
        try get("devxoul3", throws: false)
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: true),
        try get("devxoul2", throws: false),
        try get("devxoul3", throws: false)
      ),
      "devxoul2"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false),
        try get("devxoul2", throws: true),
        try get("devxoul3", throws: false)
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false),
        try get("devxoul2", throws: false),
        try get("devxoul3", throws: true)
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: true),
        try get("devxoul2", throws: false),
        try get("devxoul3", throws: true)
      ),
      "devxoul2"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: false),
        try get("devxoul2", throws: true),
        try get("devxoul3", throws: true)
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        try get("devxoul1", throws: true),
        try get("devxoul2", throws: true),
        try get("devxoul3", throws: false)
      ),
      "devxoul3"
    )
  }

}
