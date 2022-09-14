//
//  MainViewController.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 4/9/22.
//

import UIKit

class MainViewController: UIViewController {

  let mainViewModel: MainViewModel

  private lazy var transitionView = UIView()
  private var emptyView: EmptyView?
  private var placeholderPhotoListView: PlaceholderPhotoListView?

  init(viewModel: MainViewModel) {
    self.mainViewModel = viewModel
    super.init(nibName: "MainViewController", bundle: Bundle(for: MainViewController.self))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    guard let emptyView = EmptyView.loadFromNib() as? EmptyView else { return }
    transitionView.frame = emptyView.frame
    transitionView.addSubview(emptyView)

    guard let listView = PlaceholderPhotoListView.loadFromNib() as? PlaceholderPhotoListView else { return }
    listView.isHidden = true
    transitionView.addSubview(listView)

    self.emptyView = emptyView
    self.placeholderPhotoListView = listView

    self.view = transitionView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.title = mainViewModel.title
    initplaceholderPhotoListView()
    fetchPhotos { [weak self] in
      guard let self = self else { return }
      self.transitionToTableView()
    }
  }

  func fetchPhotos(completion: (() -> ())? = .none) {
    mainViewModel.photos { [weak self] result, error in
      if let error = error { print(error) } // TODO: Show error
      guard let self = self, result else { return }
      print("Fetched \(self.mainViewModel.placeholderPhotos.count) placeholder photos.")
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.reloadTable()
        completion?()
      }
    }
  }
}

extension MainViewController {
  private func transitionToTableView(completion: (() -> ())? = .none) {
    UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
      self.placeholderPhotoListView?.isHidden = false
      self.emptyView?.isHidden = true
    }, completion: { [weak self] _ in
      guard let self = self else { return }
      self.emptyView?.removeFromSuperview()
      completion?()
    })
  }

  private func initplaceholderPhotoListView() {
    self.placeholderPhotoListView?.delegate = self
    self.placeholderPhotoListView?.placeholderPhotosTableView.register(UINib(nibName: "PlaceholderPhotoTableViewCell", bundle: .main), forCellReuseIdentifier: "PhotoCellIdentifier")
  }

  private func reloadTable() {
    let tableView = self.placeholderPhotoListView?.placeholderPhotosTableView
    tableView?.reloadSections(IndexSet(integer: 0), with: .automatic)
  }
}
