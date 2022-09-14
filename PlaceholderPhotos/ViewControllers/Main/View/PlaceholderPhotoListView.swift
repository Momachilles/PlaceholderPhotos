//
//  PlaceholderPhotoListView.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

protocol PlaceholderPhotoListViewDelegate {
  func placeholderPhotoListView(view: PlaceholderPhotoListView, refreshControlValueChanged: UIRefreshControl)
}

class PlaceholderPhotoListView: UIView {

  lazy var refreshControl: UIRefreshControl = UIRefreshControl()

  @IBOutlet weak var placeholderPhotosTableView: UITableView! {
    didSet {
      placeholderPhotosTableView.rowHeight = UITableView.automaticDimension
      placeholderPhotosTableView.estimatedRowHeight = UITableView.automaticDimension

      refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
      placeholderPhotosTableView.refreshControl = refreshControl
    }
  }

  weak var delegate: (UITableViewDelegate & UITableViewDataSource & PlaceholderPhotoListViewDelegate)? {
    didSet {
      self.placeholderPhotosTableView.delegate = delegate
      self.placeholderPhotosTableView.dataSource = delegate
    }
  }
}

extension PlaceholderPhotoListView {

  @objc
  private func pullToRefresh(_ refreshControl: UIRefreshControl) {
    self.delegate?.placeholderPhotoListView(view: self, refreshControlValueChanged: refreshControl)
  }
}
