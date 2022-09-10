//
//  ResponseProtocol.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

protocol ResponseProtocol where ResponseType: Decodable {
  associatedtype ResponseType
  
  func decode(data: Data) throws -> ResponseType
}

extension ResponseProtocol {
  func decode(data: Data) throws -> ResponseType {
    try JSONDecoder().decode(ResponseType.self, from: data)
  }
}
