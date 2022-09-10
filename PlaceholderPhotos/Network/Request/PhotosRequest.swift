//
//  PhotosRequest.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 10/9/22.
//

import Foundation

class PhotosRequest: RequestProtocol {
  var request: URLRequest? {
    URLRequestFactory().withEndpoint(endpoint: PhotosEndpoint()).create()
  }
}

extension PhotosRequest: ResponseProtocol {
  typealias ResponseType = [PlaceholderPhoto]
}


