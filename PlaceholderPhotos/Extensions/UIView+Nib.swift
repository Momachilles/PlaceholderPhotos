//
//  UIView+Nib.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

extension UIView {
  class func loadFromNib() -> UIView? {
    guard let viewClass = NSClassFromString(self.description()) else { return .none }

    return UINib(
      nibName: String(describing: self),
      bundle: Bundle(for: viewClass)
    ).instantiate(withOwner: self, options: .none).first as? UIView
  }

  func loadFromNib() -> UIView? {
    UINib(
      nibName: String(describing: self),
      bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: .none).first as? UIView
  }
}
