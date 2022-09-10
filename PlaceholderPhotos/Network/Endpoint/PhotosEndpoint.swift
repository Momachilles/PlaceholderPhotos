//
//  PhotosEndpoint.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 10/9/22.
//

import Foundation

struct PhotosEndpoint: Endpoint {
  var environment: Environment { DevelopmentEnvironment() }
  var path: String { "/photos" }
  var method: HTTPMethod { .get }
}
