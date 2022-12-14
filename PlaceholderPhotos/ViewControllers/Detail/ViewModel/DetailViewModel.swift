//
//  DetailViewModel.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import UIKit

class DetailViewModel {
  private let placeholderPhoto: PlaceholderPhoto
  private var downloadImageTask: URLSessionDataTask?

  var coordinator: DetailCoordinator
  var image: UIImage? = UIImage(color: .lightGray.withAlphaComponent(0.1))
  var title: String { // Could be localized
    "Placeholder Photo Detail"
  }

  var text: String {
    placeholderPhoto.title
  }

  var onDownloadedImage: (() -> Void)?

  init(placeholderPhoto: PlaceholderPhoto, coordinator: DetailCoordinator) {
    self.placeholderPhoto = placeholderPhoto
    self.coordinator = coordinator

    downloadImageFromURL()
  }

  deinit {
    if downloadImageTask?.state == .running {
      downloadImageTask?.cancel()
    }
  }
}

extension DetailViewModel {
  private func downloadImageFromURL() {
    downloadImageTask = UIImage.imageFromServerURL(placeholderPhoto.url) { [weak self] image, error in
      guard let self = self else { return } // TODO: Error handling
      if let error = error { print(error); return } // TODO: Error handling

      self.image = image
      self.onDownloadedImage?()
    }
  }
}
