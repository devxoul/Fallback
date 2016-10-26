// The MIT License (MIT)
//
// Copyright (c) 2016 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

/// Flattens do-try-catch expressions.
///
/// For example:
///
/// ```
/// value = try fallback(
///   try get("A"),
///   try get("B"),
///   try get("C"),
///   try get("D")
/// )
/// ```
///
/// is equivalent to:
///
/// ```swift
/// do {
///   value = try get("A")
/// } catch {
///   do {
///     value = try get("B")
///   } catch {
///     do {
///       value = try get("C")
///     } catch {
///       value = try get("D")
///     }
///   }
/// }
/// ```
public func fallback<T>(
  _ closure: (@autoclosure () throws -> T),
  _ closures: (@autoclosure () throws -> T)...
) rethrows -> T {
  do {
    return try closure()
  } catch (let error) {
    for i in closures.indices {
      do {
        return try closures[i]()
      } catch(let error) {
        if i == closures.indices.last {
          throw error
        }
      }
    }
    throw error
  }
}

public func fallback<T>(
  _ closure: (() throws -> T),
  _ closures: (() throws -> T)...
) rethrows -> T {
  do {
    return try closure()
  } catch (let error) {
    for i in closures.indices {
      do {
        return try closures[i]()
      } catch(let error) {
        if i == closures.indices.last {
          throw error
        }
      }
    }
    throw error
  }
}

public enum Tryable<T> {
  case success(T)
  case failure(Error)

  public func `catch`(_ closure: @escaping (Error) throws -> T) -> Tryable<T> {
    switch self {
    case .success:
      return self

    case .failure(let error):
      do {
        return .success(try closure(error))
      } catch (let error) {
        return .failure(error)
      }
    }
  }

  public func rethrow() throws -> T {
    switch self {
    case .success(let value):
      return value

    case .failure(let error):
      throw error
    }
  }

  public func finally(_ closure: @escaping (Error) -> T) -> T {
    switch self {
    case .success(let value):
      return value

    case .failure(let error):
      return closure(error)
    }
  }
}

public func fallback<T>(_ closure: () throws -> T) -> Tryable<T> {
  do {
    return .success(try closure())
  } catch (let error) {
    return .failure(error)
  }
}
