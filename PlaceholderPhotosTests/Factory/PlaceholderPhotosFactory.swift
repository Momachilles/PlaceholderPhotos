//
//  PlaceholderPhotosFactory.swift
//  PlaceholderPhotosTests
//
//  Created by David Alarcon on 21/9/22.
//

import Foundation
@testable import PlaceholderPhotos

class PlaceholderPhotosFactory: Factory {
  func create() -> [PlaceholderPhoto]? {
    create(length: 1)
  }
}

extension PlaceholderPhotosFactory {
  func create(length: Int) -> [PlaceholderPhoto]? {
    var placeholderPhotos: [PlaceholderPhoto]?

    if length > 0 {
      placeholderPhotos = []
    }

    for i in 1...length {
      placeholderPhotos?.append(PlaceholderPhoto(title: "Title", url: "http:///host/path", thumbnailUrl: "http:///host/path/thumb"))
    }

    return placeholderPhotos
  }
}
