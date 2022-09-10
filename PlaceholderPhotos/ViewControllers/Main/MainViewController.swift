//
//  MainViewController.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

class MainViewController: UIViewController {

  override func loadView() {
    // guard let emptyView = EmptyView.loadFromNib() as? EmptyView else { return }
    guard let listView = PlaceholderPhotoListView.loadFromNib() as? PlaceholderPhotoListView else { return }

    self.view = listView // emptyView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    do {
      try PhotosAPI().photos { photos in print(photos) }
    } catch {
      print(error)
    }
  }
}
