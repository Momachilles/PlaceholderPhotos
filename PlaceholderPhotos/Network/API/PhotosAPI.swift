//
//  PhotosAPI.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

class PhotosAPI {
  
  func photos(completion: @escaping ([PlaceholderPhoto]?) -> ()) throws {
    let photosRequest = PhotosRequest()
    print(photosRequest.request(from: PhotosEndpoint()) as Any)
  }
}
