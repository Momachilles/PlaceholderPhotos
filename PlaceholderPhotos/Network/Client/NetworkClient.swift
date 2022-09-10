//
//  File.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

protocol NetworkFetch {
  associatedtype ResponseType
  
  func fetch(completion: @escaping (ResponseType?, Error?) -> ())
}

class NetworkClient<T: APIProtocol>: NetworkFetch {

  let apiRequest: T
  let urlSession: URLSession
  let reachability: Reachability

  init(apiRequest: T, urlSession: URLSession = .shared, reachibility: Reachability? = .none) throws {
    self.apiRequest = apiRequest
    self.urlSession = urlSession
    if let reachibility = reachibility {
      self.reachability = reachibility
    } else {
      self.reachability = try Reachability()
    }
  }

  func fetch(completion: @escaping (T.ResponseType?, Error?) -> ()) {
    // check network status
    // guard reachability.connection == .unavailable else { return completion (.none, NetworkError.noNetworkConnection) }
    guard let request = apiRequest.request else { return completion (.none, NetworkError.invalidRequest) }

    // do session task
    urlSession.dataTask(with: request) { data, response, error in
      if let error = error { return completion (.none, NetworkError.error(message: error.localizedDescription)) }
      guard let data = data else { return completion (.none, NetworkError.noData) }
      do {
        let decodedResponse = try self.apiRequest.decode(data: data)
        completion(decodedResponse, .none)
      } catch {
        completion(.none, NetworkError.decode(message: error.localizedDescription))
      }
    }.resume()
  }
}
