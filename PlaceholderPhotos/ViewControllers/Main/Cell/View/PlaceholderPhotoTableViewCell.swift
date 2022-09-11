//
//  PlaceholderPhotoTableViewCell.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import UIKit

class PlaceholderPhotoTableViewCell: UITableViewCell {

  @IBOutlet weak var placeholderPhotoImageView: UIImageView!
  @IBOutlet weak var placeholderPhotoLabel: UILabel!

  var viewModel: PlaceholderPhotoTableViewCellViewModel? {
    didSet {
      placeholderPhotoLabel.text = viewModel?.text
      viewModel?.onDownloadedImage = { [weak self] in
        guard let self = self else { return }
        self.placeholderPhotoImageView.image = self.viewModel?.image
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
