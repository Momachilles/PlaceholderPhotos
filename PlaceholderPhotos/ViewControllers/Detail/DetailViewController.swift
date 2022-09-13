//
//  DetailViewController.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import UIKit

class DetailViewController: UIViewController {

  private let detailViewModel:DetailViewModel

  init(viewModel: DetailViewModel) {
    self.detailViewModel = viewModel
    super.init(nibName: "DetailViewController", bundle: Bundle(for: MainViewController.self))
  }

  override func loadView() {
    guard let detailView = DetailView.loadFromNib() as? DetailView else { return }
    detailView.viewModel = detailViewModel

    self.view = detailView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    self.title = detailViewModel.title
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
