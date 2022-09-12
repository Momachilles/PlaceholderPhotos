//
//  Coordinator.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 12/9/22.
//

import UIKit

protocol Coordinator {
  var parentCoordinator: Coordinator? { get set }
  var children: [Coordinator] { get set }
  var navigationController : UINavigationController { get set }

  func start()
}
