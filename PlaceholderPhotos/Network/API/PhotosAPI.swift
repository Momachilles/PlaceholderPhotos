//
//  PhotosAPI.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

class PhotosAPI: NetworkAPI {

  var networkClient: NetworkClient?

  init(networkClient: NetworkClient) {
    self.networkClient = networkClient
  }

  func photos(completion: @escaping ([PlaceholderPhoto]?, Error?) -> ()) {
    let photosRequest = PhotosRequest()

    networkClient?.fetch(apiRequest: photosRequest) { photos, error in
      completion(photos, error)
    }
  }
}
