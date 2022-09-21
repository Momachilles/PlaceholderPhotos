//
//  URLProtocolStub.swift
//  PlaceholderPhotosTests
//
//  Created by David Alarcon on 21/9/22.
//

import XCTest

typealias URLProtocolHandler = ((URLRequest) throws -> (HTTPURLResponse?, Data?))

class URLProtocolStub: URLProtocol {
  static var handler: URLProtocolHandler?

  override class func canInit(with request: URLRequest) -> Bool { true }
  override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

  override func startLoading() {
    guard let handler = Self.handler else {
      XCTFail("Handler should be set.")

      return
    }

    do {
      let (response, data) = try handler(request)
      if let response = response { client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed) }
      if let data = data { client?.urlProtocol(self, didLoad: data) }
      client?.urlProtocolDidFinishLoading(self)
    } catch {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }

  override func stopLoading() {}
}
