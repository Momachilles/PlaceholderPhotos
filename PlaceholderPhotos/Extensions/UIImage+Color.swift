//
//  UIImage+Color.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import Foundation
import UIKit

extension UIImage {
  convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    guard let cgImage = UIGraphicsImageRenderer(size: size).image(actions: { rendererContext in
      color.setFill()
      rendererContext.fill(CGRect(origin: .zero, size: size))
    }).cgImage
    else { return nil }

    self.init(cgImage: cgImage)
  }
}
