//
//  PlaceholderPhotoListView.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

class PlaceholderPhotoListView: UIView {

  @IBOutlet weak var placeholderPhotosTableView: UITableView! {
    didSet {
      placeholderPhotosTableView.rowHeight = UITableView.automaticDimension
      placeholderPhotosTableView.estimatedRowHeight = UITableView.automaticDimension
    }
  }

  weak var delegate: (UITableViewDelegate & UITableViewDataSource)? {
    didSet {
      self.placeholderPhotosTableView.delegate = delegate
      self.placeholderPhotosTableView.dataSource = delegate
    }
  }
}
