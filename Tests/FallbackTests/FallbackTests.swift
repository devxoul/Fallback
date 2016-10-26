import XCTest
@testable import Fallback

struct TestError<T>: Error {
  let value: T
  init(_ value: T) {
    self.value = value
  }
}

func get<T>(_ value: T, throws: Bool) throws -> T {
  if `throws` {
    throw TestError(value)
  }
  return value
}

final class FallbackTests: XCTestCase {

  static var allTests: [(String, (FallbackTests) -> () throws -> Void)] {
    return [
      ("testFallback_throws", testFallback_throws),
      ("testFallback", testFallback),
      ("testFallbackClosure_throws", testFallbackClosure_throws),
      ("testFallbackClosure", testFallbackClosure),
      ("testFallbackClosure_defaultValue", testFallbackClosure_defaultValue),
    ]
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

  func testFallbackClosure_throws() {
    XCTAssertThrowsError(
      try fallback(
        { try get("devxoul1", throws: true) }
      ) as String
    )
    XCTAssertThrowsError(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: true) }
      ) as String
    )
    XCTAssertThrowsError(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: true) },
        { try get("devxoul3", throws: true) }
      ) as String
    )
  }

  func testFallbackClosure() {
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) }
      ),
      "devxoul1"
    )

    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) },
        { try get("devxoul2", throws: false) }
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) },
        { try get("devxoul2", throws: true) }
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: false) }
      ),
      "devxoul2"
    )

    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) },
        { try get("devxoul2", throws: false) },
        { try get("devxoul3", throws: false) }
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: false) },
        { try get("devxoul3", throws: false) }
      ),
      "devxoul2"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) },
        { try get("devxoul2", throws: true) },
        { try get("devxoul3", throws: false) }
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) },
        { try get("devxoul2", throws: false) },
        { try get("devxoul3", throws: true) }
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: false) },
        { try get("devxoul3", throws: true) }
      ),
      "devxoul2"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: false) },
        { try get("devxoul2", throws: true) },
        { try get("devxoul3", throws: true) }
      ),
      "devxoul1"
    )
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: true) },
        { try get("devxoul3", throws: false) }
      ),
      "devxoul3"
    )
  }

  func testFallbackClosure_defaultValue() {
    XCTAssertEqual(
      try fallback(
        { try get("devxoul1", throws: true) },
        { try get("devxoul2", throws: true) },
        { return "devxoul3" }
      ),
      "devxoul3"
    )
  }

  func testFallbackTryableRethrow_throws() {
    XCTAssertThrowsError(
      try fallback {
        return try get("a", throws: true)
      }.rethrow()
    )
    XCTAssertThrowsError(
      try fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: true)
      }.rethrow()
    )
    XCTAssertThrowsError(
      try fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: true)
      }.catch { error in
        return try get("c", throws: true)
      }.rethrow()
    )
  }

  func testFallbackTryableRethrow() {
    XCTAssertEqual(
      try fallback {
        return try get("a", throws: false)
      }.rethrow(),
      "a"
    )

    XCTAssertEqual(
      try fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: true)
      }.rethrow(),
      "a"
    )
    XCTAssertEqual(
      try fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: false)
      }.rethrow(),
      "a"
    )

    XCTAssertEqual(
      try fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: true)
      }.catch { error in
        return try get("c", throws: true)
      }.rethrow(),
      "a"
    )
    XCTAssertEqual(
      try fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: false)
      }.catch { error in
        return try get("c", throws: true)
      }.rethrow(),
      "a"
    )
    XCTAssertEqual(
      try fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: false)
      }.catch { error in
        return try get("c", throws: false)
      }.rethrow(),
      "a"
    )
    XCTAssertEqual(
      try fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: false)
      }.catch { error in
        return try get("c", throws: false)
      }.rethrow(),
      "b"
    )
    XCTAssertEqual(
      try fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: true)
      }.catch { error in
        return try get("c", throws: false)
      }.rethrow(),
      "c"
    )
  }

  func testFallbackTryableFinally() {
    XCTAssertEqual(
      fallback {
        return try get("a", throws: true)
      }.finally { error in
        return "none"
      },
      "none"
    )
    XCTAssertEqual(
      fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: true)
      }.finally { error in
        return "none"
      },
      "none"
    )
    XCTAssertEqual(
      fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: true)
      }.catch { error in
        return try get("c", throws: true)
      }.finally { error in
        return "none"
      },
      "none"
    )

    XCTAssertEqual(
      fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: true)
      }.catch { error in
        return try get("c", throws: true)
      }.finally { error in
        return "none"
      },
      "a"
    )
    XCTAssertEqual(
      fallback {
        return try get("a", throws: false)
      }.catch { error in
        return try get("b", throws: false)
      }.catch { error in
        return try get("c", throws: true)
      }.finally { error in
        return "none"
      },
      "a"
    )
    XCTAssertEqual(
      fallback {
        return try get("a", throws: true)
      }.catch { error in
        return try get("b", throws: false)
      }.catch { error in
        return try get("c", throws: false)
      }.finally { error in
        return "none"
      },
      "b"
    )
  }

}
