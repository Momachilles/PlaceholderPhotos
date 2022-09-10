//
//  RequestProtocol.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

typealias APIProtocol = RequestProtocol & ResponseProtocol

protocol RequestProtocol {
  var request: URLRequest? { get }
}
