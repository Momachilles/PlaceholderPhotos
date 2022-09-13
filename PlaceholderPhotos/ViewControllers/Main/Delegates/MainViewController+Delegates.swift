//
//  MainViewController+Delegates.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 13/9/22.
//

import UIKit

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    mainViewModel.placeholderPhotos.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCellIdentifier") as? PlaceholderPhotoTableViewCell else { return UITableViewCell() }
    let placeholderPhoto = mainViewModel.placeholderPhotos[indexPath.row]

    // Reset content
    /*
     The table view's delegate in tableView(_:cellForRowAt:) should always reset all content when reusing a cell.
     */
    cell.placeholderPhotoImageView.image = .none
    cell.placeholderPhotoLabel.text = .none

    let viewModel = PlaceholderPhotoTableViewCellViewModel(placeholderPhoto: placeholderPhoto)
    cell.viewModel = viewModel

    return cell
  }
}

extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let placeholderPhoto = mainViewModel.placeholderPhotos[indexPath.row]
    mainViewModel.coordinator?.didSelectRow(with: placeholderPhoto)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension MainViewController: PlaceholderPhotoListViewDelegate {

  func placeholderPhotoListView(view: PlaceholderPhotoListView, refreshControlValueChanged: UIRefreshControl) {
    refreshControlValueChanged.endRefreshing()
    fetchPhotos()
  }
}
