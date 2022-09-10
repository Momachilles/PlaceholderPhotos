//
//  MainViewController.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

class MainViewController: UIViewController {

  private var photos: [PlaceholderPhoto] = []

  override func loadView() {
    // guard let emptyView = EmptyView.loadFromNib() as? EmptyView else { return }
    guard let listView = PlaceholderPhotoListView.loadFromNib() as? PlaceholderPhotoListView else { return }

    self.view = listView // emptyView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    do {
      try PhotosAPI().photos { photos in print(photos as Any) }
    } catch {
      print(error)
    }
  }

  func fetchPhotos() {
    try? PhotosAPI().photos { [weak self] photos in
      guard let self = self else { return }
      self.photos = photos
    }
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    photos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCellIdentifier", for: indexPath)

    let placeholderPhoto = self.photos[indexPath.row]
    cell.textLabel?.text = placeholderPhoto.title

    return cell
  }
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}
