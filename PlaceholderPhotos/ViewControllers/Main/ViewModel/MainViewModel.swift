//
//  MainViewModel.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

class MainViewModel {
  weak var coordinator: MainCoordinator?
  var placeholderPhotos: [PlaceholderPhoto] = []

  init(coordinator: MainCoordinator) {
    self.coordinator = coordinator
  }

  func photos(completion: @escaping (() -> ())) throws {
    try PhotosAPI().photos { [weak self] photos in
      guard let self = self else { return }
      self.placeholderPhotos = photos
      completion()
    }
  }
}