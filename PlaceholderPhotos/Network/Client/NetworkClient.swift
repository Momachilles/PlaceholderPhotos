//
//  File.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

protocol NetworkFetch {
  func fetch<T: APIRequest>(apiRequest: T, completion: @escaping (T.ResponseType?, Error?) -> ())
}

class NetworkClient: NetworkFetch {

  let urlSession: URLSession
  let reachability: Reachability

  init(urlSession: URLSession = .shared, reachibility: Reachability? = .none) throws {
    self.urlSession = urlSession
    if let reachibility = reachibility {
      self.reachability = reachibility
    } else {
      self.reachability = try Reachability()
    }
  }

  func fetch<T: APIRequest>(apiRequest: T, completion: @escaping (T.ResponseType?, Error?) -> ()) {
    // check network status
    // guard reachability.connection == .unavailable else { return completion (.none, NetworkError.noNetworkConnection) }
    guard let request = apiRequest.request else { return completion (.none, NetworkError.invalidRequest) }

    // do session task
    urlSession.dataTask(with: request) { data, response, error in
      if let error = error { return completion (.none, NetworkError.error(message: error.localizedDescription)) }
      guard let response = response as? HTTPURLResponse else { return completion(.none, NetworkError.invalidResponse) }
      guard 200 ..< 300 ~= response.statusCode else { return completion(.none, NetworkError.status(status: String(response.statusCode))) }
      guard let data = data, data.count > 0 else { return completion (.none, NetworkError.noData) }
      do {
        let decodedResponse = try apiRequest.decode(data: data)
        completion(decodedResponse, .none)
      } catch {
        completion(.none, NetworkError.decode(message: error.localizedDescription))
      }
    }.resume()
  }
}
