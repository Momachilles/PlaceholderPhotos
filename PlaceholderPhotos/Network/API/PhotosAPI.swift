//
//  PhotosAPI.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

class PhotosAPI {
  
  func photos(completion: @escaping ([PlaceholderPhoto]) -> ()) throws {
    let photosRequest = PhotosRequest()

    try? NetworkClient(apiRequest: photosRequest).fetch { photos, error in
      if let error = error {
        print(error)
      }
      else {
        if let photos = photos { completion(photos) } // Error if .none
      }
    }
  }
}
