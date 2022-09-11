//
//  UIImageView+Download.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 10/9/22.
//

import UIKit

/* URL: https://stackoverflow.com/questions/37018916/swift-async-load-image */
extension UIImageView {

  func imageFromServerURL(_ URLString: String,
                          urlSession: URLSession = .shared,
                          placeHolder: UIImage? = .none,
                          completion: @escaping ((Bool, Error?) -> ())) {
    guard let imageURL = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: imageURL)
    else { return }

    if let placeHolder = placeHolder {
      DispatchQueue.main.async { self.image = placeHolder }
    }

    urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error { return completion(false, NetworkError.error(message: error.localizedDescription)) }
      guard let response = response as? HTTPURLResponse else { return completion(false, NetworkError.invalidResponse) }
      guard 200 ..< 300 ~= response.statusCode else { return completion(false, NetworkError.status(status: String(response.statusCode))) }
      guard let data = data else { return completion(false, NetworkError.noData) }
      guard let downloadedImage = UIImage(data: data) else { return completion(false, NetworkError.error(message: "Error creating the image")) }

      DispatchQueue.main.async {
        self.image = downloadedImage
        completion(true, .none)
      }
    }).resume()
  }
}
