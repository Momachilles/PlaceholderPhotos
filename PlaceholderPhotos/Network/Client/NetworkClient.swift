//
//  File.swift
//  PlaceholderPhotos
//
//  Created by David Alarcon on 9/9/22.
//

import Foundation

protocol NetworkFetch {
  associatedtype T
  
  func fetch()
}

class NetworkClient<T: Any>: NetworkFetch {
  
  func fetch() {
    
  }
}
