//
//  PhotosAPI.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

class PhotosAPI: NetworkAPI {

  private var networkClient: NetworkClient

  required init(client: NetworkClient) {
    self.networkClient = client
  }

  func photos(completion: @escaping ([PlaceholderPhoto]?, Error?) -> ()) {
    let photosRequest = PhotosRequest()

    networkClient.fetch(apiRequest: photosRequest) { photos, error in
      completion(photos, error)
    }
  }
}
