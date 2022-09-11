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

  var image: UIImage? {
    return .none
  }

  var text: String {
    placeholderPhoto.title
  }

  init(placeholderPhoto: PlaceholderPhoto) {
    self.placeholderPhoto = placeholderPhoto
  }
}
