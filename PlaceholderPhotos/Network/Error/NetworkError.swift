//
//  NetworkError.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 10/9/22.
//

import Foundation

enum NetworkError: Error {
case noNetworkConnection
case invalidRequest
case noData
case error(message: String)
case decode(message: String)
}
