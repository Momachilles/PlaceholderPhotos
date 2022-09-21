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
case invalidResponse
case status(status: String)
case noData
case error(message: String)
case decode(message: String)
}

extension NetworkError: CustomStringConvertible {
  var description: String {
    switch self {
      case .noNetworkConnection:
        return "No network connection."
      case .invalidRequest:
        return "Invalid Request."
      case .invalidResponse:
        return "Invalid Response."
      case .status(status: let status):
        return "Invalid status: \(status)."
      case .noData:
        return "No Data."
      case .error(message: let message):
        return message
      case .decode(message: let message):
        return message
    }
  }
}

extension NetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
      case .noNetworkConnection:
        return NSLocalizedString("No network connection.", comment: "No network connection.")
      case .invalidRequest:
        return NSLocalizedString("Invalid Request.", comment: "Invalid Request.")
      case .invalidResponse:
        return NSLocalizedString("Invalid Response.", comment: "Invalid Response.")
      case .status(status: let status):
        return NSLocalizedString("Invalid status: \(status).", comment: "Invalid status: \(status).")
      case .noData:
        return NSLocalizedString("No Data.", comment: "No Data.")
      case .error(message: let message):
        return NSLocalizedString(message, comment: message)
      case .decode(message: let message):
        return NSLocalizedString(message, comment: message)
    }
  }
}
