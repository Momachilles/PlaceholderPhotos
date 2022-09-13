//
//  Request.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

typealias APIRequest = Request & Response

protocol Request {
  var request: URLRequest? { get }
}
