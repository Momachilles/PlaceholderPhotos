//
//  AppCordinator.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 12/9/22.
//

import UIKit

class AppCordinator: Coordinator {

  private var window: UIWindow?
  var navigationController: UINavigationController = UINavigationController()
  var parentCoordinator: Coordinator?
  var children: [Coordinator] = []

  init(window: UIWindow?) {
    self.window = window
  }

  func start() {
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    let coordinator = MainCoordinator(navigationController: navigationController)
    children.append(coordinator)
    coordinator.parentCoordinator = self
    coordinator.start()
  }
}
