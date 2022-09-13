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

  private let networkService: NetworkService

  init(window: UIWindow?, networkService: NetworkService) {
    self.window = window
    self.networkService = networkService
  }

  func start() {
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    let coordinator = MainCoordinator(navigationController: navigationController, networkService: networkService)
    children.append(coordinator)
    coordinator.parentCoordinator = self
    coordinator.start()
  }
}
