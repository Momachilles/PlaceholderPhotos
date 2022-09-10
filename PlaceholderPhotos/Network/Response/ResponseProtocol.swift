//
//  ResponseProtocol.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

protocol ResponseProtocol where T: Decodable {
  associatedtype T
  
  func decode(data: Data) throws -> T
}

extension ResponseProtocol {
  func decode(data: Data) throws -> T {
    try JSONDecoder().decode(T.self, from: data)
  }
}
