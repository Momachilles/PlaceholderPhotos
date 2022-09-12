//
//  MainCoordinator.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 12/9/22.
//

import UIKit

class MainCoordinator: Coordinator {

  var navigationController: UINavigationController
  var parentCoordinator: Coordinator?
  var children: [Coordinator] = []

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let mainViewController = MainViewController(viewModel: MainViewModel(coordinator: self))
    navigationController.pushViewController(mainViewController, animated: false)
  }
}

extension MainCoordinator {
  func didSelectRow(with placeholderPhoto: PlaceholderPhoto) {
    let coordinator = DetailCoordinator(navigationController: navigationController)
    children.append(coordinator)
    coordinator.parentCoordinator = self
    coordinator.placeholderPhoto = placeholderPhoto
    coordinator.start()
  }
}
