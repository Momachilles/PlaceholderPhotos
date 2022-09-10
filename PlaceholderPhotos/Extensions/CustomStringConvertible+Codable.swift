//
//  CustomStringConvertible+Codable.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

/* URL: https://levelup.gitconnected.com/automate-debugging-swift-objects-using-the-customstringconvertible-protocol-c01fff74380f */
extension CustomStringConvertible where Self: Codable {
  var description: String {
    var description = "\n***** \(type(of: self)) *****\n"
    let selfMirror = Mirror(reflecting: self)
    for child in selfMirror.children {
      if let propertyName = child.label {
        description += "\(propertyName): \(child.value)\n"
      }
    }
    return description
  }
}
