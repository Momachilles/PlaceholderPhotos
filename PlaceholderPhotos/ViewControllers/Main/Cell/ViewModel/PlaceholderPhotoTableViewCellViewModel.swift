//
//  PlaceholderPhotoTableViewCellViewModel.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import Foundation
import UIKit

class PlaceholderPhotoTableViewCellViewModel {

  private let placeholderPhoto: PlaceholderPhoto
  private var downloadedImage: UIImage?

  var image: UIImage? {
    return downloadedImage
  }

  var text: String {
    placeholderPhoto.title
  }

  var onDownloadedPhoto: (() -> Void)?

  init(placeholderPhoto: PlaceholderPhoto) {
    self.placeholderPhoto = placeholderPhoto

    downloadImageFromThumbnailURL()
  }
}

extension PlaceholderPhotoTableViewCellViewModel {
  private func downloadImageFromThumbnailURL() {
    guard let url = URL(string: placeholderPhoto.thumbnailUrl) else { return }

    DispatchQueue.global().async {
      guard let data = try? Data(contentsOf: url) else { return }
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.downloadedImage = UIImage(data: data)
        self.onDownloadedPhoto?()
      }
    }
  }
}
