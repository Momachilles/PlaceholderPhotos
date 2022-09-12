//
//  DetailView.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import UIKit

class DetailView: UIView {
  @IBOutlet weak var detailImageView: UIImageView!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
    didSet {
      activityIndicatorView.startAnimating()
    }
  }

  var viewModel: DetailViewModel? {
    didSet {
      detailImageView.image = viewModel?.image
      detailLabel.text = viewModel?.text
      viewModel?.onDownloadedImage = { [weak self] in
        guard let self = self else { return }
        self.activityIndicatorView.stopAnimating()
        UIView.transition(with: self.detailImageView, duration: 0.3, options: .transitionCrossDissolve) {
          self.detailImageView.image = self.viewModel?.image
        }
      }
    }
  }
}
