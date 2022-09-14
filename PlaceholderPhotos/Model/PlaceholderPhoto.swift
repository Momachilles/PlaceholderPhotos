//
//  PlaceholderPhoto.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import Foundation

struct PlaceholderPhoto: Codable, CustomStringConvertible {
  /// INFO: We could also add 'albumId' and 'id' but we are not using them in this app.
  let title: String
  let url: String
  let thumbnailUrl: String
}

