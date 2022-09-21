//
//  URLSessionFactory.swift
//  PlaceholderPhotosTests
//
//  Created by David Alarcon on 21/9/22.
//

import Foundation
@testable import PlaceholderPhotos

class URLSessionFactory: Factory {
  func create() -> URLSession? {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [URLProtocolStub.self] + (configuration.protocolClasses ?? [])

    return URLSession(configuration: configuration)
  }
}
