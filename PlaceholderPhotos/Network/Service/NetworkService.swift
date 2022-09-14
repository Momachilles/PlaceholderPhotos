//
//  NetworkService.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 13/9/22.
//

import Foundation

class NetworkService: Service {

  /// A service that can have a task queue, a log, reachability, ...

  var networkClient: NetworkClient?

  func start() {
    print("Start network service ...")
    networkClient = try? NetworkClient()
  }
  func stop() {
    print("Stop network service ...")
    networkClient = .none
  }
}
