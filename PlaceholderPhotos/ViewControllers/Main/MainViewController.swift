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

    guard let view = self.view as? PlaceholderPhotoListView else { return }

    view.delegate = self
    view.placeholderPhotosTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PhotoCellIdentifier")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    fetchPhotos()
  }

  func fetchPhotos() {
    try? PhotosAPI().photos { [weak self] photos in
      guard let self = self else { return }
      self.photos = photos
      DispatchQueue.main.async {
        let tableView = (self.view as? PlaceholderPhotoListView)?.placeholderPhotosTableView
        tableView?.reloadSections(IndexSet(integer: 0), with: .automatic)
      }
    }
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    photos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCellIdentifier") else { return UITableViewCell() }
    let placeholderPhoto = self.photos[indexPath.row]

    // Reset cell
    cell.imageView?.image = .none
    cell.textLabel?.text = .none
    cell.detailTextLabel?.text = .none
    cell.layoutSubviews()

    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.text = placeholderPhoto.title
    cell.textLabel?.sizeToFit()
    cell.detailTextLabel?.text = nil
    cell.detailTextLabel?.sizeToFit()
    cell.imageView?.imageFromServerURL(placeholderPhoto.thumbnailUrl, completion: { [weak cell] result, error in
      if let error = error { print(error) }
      cell?.layoutSubviews()
    })

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}
