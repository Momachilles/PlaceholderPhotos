//
//  DevelopmentEnvironment.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 10/9/22.
//

import Foundation

struct DevelopmentEnvironment: Environment {
  var baseURL: String {
    "https://jsonplaceholder.typicode.com"
  }
}
