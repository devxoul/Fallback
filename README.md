Fallback
========

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Build Status](https://travis-ci.org/devxoul/Fallback.svg?branch=master)](https://travis-ci.org/devxoul/Fallback)
[![CocoaPods](http://img.shields.io/cocoapods/v/Fallback.svg)](https://cocoapods.org/pods/Fallback)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Syntactic sugar for Swift do-try-catch.

## At a Glance

```swift
value = try fallback(
  try get("A"),
  try get("B"),
  try get("C"),
  try get("D")
)
```

is equivalent to:

```swift
do {
  value = try get("A")
} catch {
  do {
    value = try get("B")
  } catch {
    do {
      value = try get("C")
    } catch {
      value = try get("D")
    }
  }
}
```

## Installation

- **Using [CocoaPods](https://cocoapods.org)**:

    ```ruby
    pod 'Fallback', '~> 0.2'
    ```

- **Using [Carthage](https://github.com/Carthage/Carthage)**:

    ```
    github "devxoul/Fallback" ~> 0.2
    ```

- **Using [Swift Package Manager](https://swift.org/package-manager)**:

    ```swift
    import PackageDescription

    let package = Package(
      name: "MyAwesomeProject",
      targets: [],
      dependencies: [
        .Package(url: "https://github.com/devxoul/Fallback.git", majorVersion: 0)
      ]
    )
    ```

## License

**Fallback** is under MIT license. See the [LICENSE](LICENSE) file for more info.
