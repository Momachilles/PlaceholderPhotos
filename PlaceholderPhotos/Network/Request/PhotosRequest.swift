//
//  PhotosRequest.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 10/9/22.
//

import Foundation

class PhotosRequest: RequestProtocol, ResponseProtocol {
  typealias T = [PlaceholderPhoto]
  
  func request(from endpoint: Endpoint) -> URLRequest? {
    URLRequestFactory().withEndpoint(endpoint: endpoint).create()
  }
}


