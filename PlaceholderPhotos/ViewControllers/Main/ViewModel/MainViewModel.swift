//
//  MainViewModel.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

class MainViewModel {
  private let networkClient: NetworkClient

  weak var coordinator: MainCoordinator?
  var placeholderPhotos: [PlaceholderPhoto] = []

  init(coordinator: MainCoordinator, networkClient: NetworkClient) {
    self.coordinator = coordinator
    self.networkClient = networkClient
  }

  func photos(completion: @escaping ((Bool, Error?) -> ())) {
    PhotosAPI(networkClient: networkClient).photos { [weak self] photos, error in
      if let error = error { return completion(false, error) }
      guard let self = self, let photos = photos else { return completion(false, .none) }
      self.placeholderPhotos = photos
      completion(true, .none)
    }
  }
}
