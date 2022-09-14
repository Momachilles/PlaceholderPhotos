//
//  URLRequestFactory.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

protocol Factory {
  associatedtype T
  
  func create() -> T?
}

class URLRequestFactory: Factory {
  
  private var urlRequest: URLRequest?
  private var endpoint: Endpoint?
  
  func withEndpoint(endpoint: Endpoint) -> Self {
    self.endpoint = endpoint
    
    if let url = url {
    self.urlRequest = URLRequest(url: url)
    }
    
    return self
  }
  
  func create() -> URLRequest? {
    urlRequest
  }
  
}

extension URLRequestFactory {
  private var url: URL? {
    guard let endpoint = endpoint,
          var components = URLComponents(string: endpoint.environment.baseURL)
    else { return .none }
    
    components.path = endpoint.path
    
    if endpoint.method == .get {
      components.queryItems = endpoint.params.map {
        URLQueryItem(name: $0.key, value: $0.value as? String)
      }
    }
    
    return components.url
  }
}
