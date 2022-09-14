//
//  Endpoint.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

/* URL: */
enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

//protocol Request {
//  associatedtype Response
//
//  var url: String { get }
//  var method: HTTPMethod { get }
//  var headers: [String : String] { get }
//  var params: [String : Any] { get }
//
//  func decode(_ data: Data) throws -> Response
//}
//
//extension Request where Response: Decodable {
//  func decode(_ data: Data) throws -> Response {
//    let decoder = JSONDecoder()
//
//    return try decoder.decode(Response.self, from: data)
//  }
//}
//
//extension Request {
//  var headers: [String : String] { [:] }
//  var queryItems: [String : String] { [:] }
//}

//protocol Request {
//  var urlRequest: URLRequest { get }
//}
//
//class NetworkRequest: Request {
//  
//  private var request: URLRequest
//  
//  init(urlRequest: URLRequest) {
//    self.request = urlRequest
//  }
//  
//  var urlRequest: URLRequest {
//    return request
//  }
//}

protocol Endpoint {
  var environment: Environment { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String : String] { get }
  var params: [String : Any] { get }
}

extension Endpoint {
  var headers: [String : String] { [:] }
  var params: [String : Any] { [:] }
}
