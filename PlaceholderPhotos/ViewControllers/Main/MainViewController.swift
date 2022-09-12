//
//  MainViewController.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

class MainViewController: UIViewController {

  private let mainViewModel: MainViewModel

  init(viewModel: MainViewModel) {
    self.mainViewModel = viewModel
    super.init(nibName: "MainViewController", bundle: Bundle(for: MainViewController.self))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    // guard let emptyView = EmptyView.loadFromNib() as? EmptyView else { return }
    guard let listView = PlaceholderPhotoListView.loadFromNib() as? PlaceholderPhotoListView else { return }

    self.view = listView // emptyView

    guard let view = self.view as? PlaceholderPhotoListView else { return }

    view.delegate = self
    view.placeholderPhotosTableView.register(UINib(nibName: "PlaceholderPhotoTableViewCell", bundle: .main), forCellReuseIdentifier: "PhotoCellIdentifier")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    fetchPhotos()
  }

  func fetchPhotos(completion: (() -> ())? = .none) {
    try? mainViewModel.photos { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.async {
        let tableView = (self.view as? PlaceholderPhotoListView)?.placeholderPhotosTableView
        tableView?.reloadSections(IndexSet(integer: 0), with: .automatic)
        completion?()
      }
    }
  }
}

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
    fetchPhotos {
      refreshControlValueChanged.endRefreshing()
    }
  }
}
