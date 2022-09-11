//
//  UIImage+Download.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 11/9/22.
//

import Foundation
import UIKit

/* URL: https://stackoverflow.com/questions/37018916/swift-async-load-image */
extension UIImage {
  static func imageFromServerURL(_ URLString: String,
                                 urlSession: URLSession = .shared,
                                 completion: @escaping ((UIImage?, Error?) -> ())) -> URLSessionDataTask? {
    guard let imageURL = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: imageURL)
    else { return .none }

    let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error { return completion(.none, NetworkError.error(message: error.localizedDescription)) }
      guard let response = response as? HTTPURLResponse else { return completion(.none, NetworkError.invalidResponse) }
      guard 200 ..< 300 ~= response.statusCode else { return completion(.none, NetworkError.status(status: String(response.statusCode))) }
      guard let data = data else { return completion(.none, NetworkError.noData) }
      guard let downloadedImage = UIImage(data: data) else { return completion(.none, NetworkError.error(message: "Error creating the image")) }

      DispatchQueue.main.async {
        completion(downloadedImage, .none)
      }
    })
    task.resume()

    return task
  }
}
