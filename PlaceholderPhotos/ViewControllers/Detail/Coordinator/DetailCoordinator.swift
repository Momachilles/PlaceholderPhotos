//
//  DetailCoordinator.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 12/9/22.
//

import UIKit

class DetailCoordinator: Coordinator {
  var navigationController: UINavigationController
  var parentCoordinator: Coordinator?
  var children: [Coordinator] = []

  var placeholderPhoto: PlaceholderPhoto?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    guard let placeholderPhoto = placeholderPhoto else { return }

    let detailViewController = DetailViewController(viewModel: DetailViewModel(placeholderPhoto: placeholderPhoto, coordinator: self))
    navigationController.pushViewController(detailViewController, animated: true)
  }
}
