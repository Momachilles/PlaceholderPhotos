//
//  NetworkAPI.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 13/9/22.
//

import Foundation

protocol NetworkAPI {
  var networkClient: NetworkClient? { get set }
}
