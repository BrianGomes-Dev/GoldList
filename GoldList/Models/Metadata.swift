/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

enum Metadata: Codable, Equatable {
  case string(String)
  case int(Int)
  case double(Double)
  case bool(Bool)
  case object([String: Metadata])
  case array([Metadata])
  case null
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let value = try? container.decode(String.self) {
      self = .string(value)
    } else if let value = try? container.decode(Int.self) {
      self = .int(value)
    } else if let value = try? container.decode(Double.self) {
      self = .double(value)
    } else if let value = try? container.decode(Bool.self) {
      self = .bool(value)
    } else if let value = try? container.decode([String: Metadata].self) {
      self = .object(value)
    } else if let value = try? container.decode([Metadata].self) {
      self = .array(value)
    } else if container.decodeNil() {
      self = .null
    } else {
      throw DecodingError.dataCorrupted(DecodingError.Context(
        codingPath: decoder.codingPath,
        debugDescription: "Invalid JSON"))
    }
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .string(let string):
      try container.encode(string)
    case .int(let int):
      try container.encode(int)
    case .double(let double):
      try container.encode(double)
    case .bool(let bool):
      try container.encode(bool)
    case .object(let object):
      try container.encode(object)
    case .array(let array):
      try container.encode(array)
    case .null:
      try container.encodeNil()
    }
  }
  
  var stringValue: String? {
    switch self {
    case .string(let string):
      return string
    default:
      return nil
    }
  }
  
  var intValue: Int? {
    switch self {
    case .int(let int):
      return int
    default:
      return nil
    }
  }
  
  var doubleValue: Double? {
    switch self {
    case .double(let double):
      return double
    default:
      return nil
    }
  }
  
  var boolValue: Bool? {
    switch self {
    case .bool(let bool):
      return bool
    default:
      return nil
    }
  }
  
  var array: [Metadata]? {
    switch self {
    case .array(let array):
      return array
    default:
      return nil
    }
  }
  
  var object: [String : Metadata]? {
    switch self {
    case .object(let object):
      return object
    default:
      return nil
    }
  }
}
