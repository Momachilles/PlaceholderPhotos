//
//  NetworkClientTests.swift
//  PlaceholderPhotosTests
//
//  Created by David Alarcon on 21/9/22.
//

import XCTest
@testable import PlaceholderPhotos

class NetworkClientTests: XCTestCase {

  func test_fetch_whenIsSuccessful_withoutReachability() throws {
    guard let urlSession = URLSessionFactory().create() else { XCTFail("URL should not be optional"); return }
    let client = try NetworkClient(urlSession: urlSession)
    let expectation = XCTestExpectation(description: "response")
    let photos = setSuccessfulOneElementHandler()

    client.fetch(apiRequest: DummyRequest()) { receivedPhotos, error in
      defer {
        expectation.fulfill()
      }

      XCTAssertNil(error)
      XCTAssertNotNil(receivedPhotos)
      XCTAssertEqual(receivedPhotos?.count, photos?.count)
      XCTAssertEqual(photos, receivedPhotos)
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_fetch_whenIsSuccessful_withReachability() throws {
    guard let urlSession = URLSessionFactory().create() else { XCTFail("URL should not be optional"); return }
    let client = try NetworkClient(urlSession: urlSession, reachibility: Reachability())
    let expectation = XCTestExpectation(description: "response")
    let photos = setSuccessfulOneElementHandler()

    client.fetch(apiRequest: DummyRequest()) { receivedPhotos, error in
      defer {
        expectation.fulfill()
      }

      XCTAssertNil(error)
      XCTAssertNotNil(receivedPhotos)
      XCTAssertEqual(receivedPhotos?.count, photos?.count)
      XCTAssertEqual(photos, receivedPhotos)
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_fetch_whenNoData() throws {
    guard let urlSession = URLSessionFactory().create() else { XCTFail("URL should not be optional"); return }
    let client = try NetworkClient(urlSession: urlSession)
    let expectation = XCTestExpectation(description: "response")
    setNoDataHandler()

    client.fetch(apiRequest: DummyRequest()) { receivedPhotos, error in
      defer {
        expectation.fulfill()
      }
      XCTAssertNotNil(error)
      guard case .noData = error as? NetworkError else {
        XCTFail("The error is not the right type: \(String(describing: error))."); return
      }
      XCTAssertNil(receivedPhotos)
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_fetch_whenNoResponse() throws {
    guard let urlSession = URLSessionFactory().create() else { XCTFail("URL should not be optional"); return }
    let client = try NetworkClient(urlSession: urlSession)
    let expectation = XCTestExpectation(description: "response")
    setNoResponseHandler()

    client.fetch(apiRequest: DummyRequest()) { receivedPhotos, error in
      defer {
        expectation.fulfill()
      }
      XCTAssertNotNil(error)
      guard case .invalidResponse = error as? NetworkError else {
        XCTFail("The error is not the right type: \(String(describing: error))."); return
      }
      XCTAssertNil(receivedPhotos)
    }

    wait(for: [expectation], timeout: 1)
  }

  func test_fetch_whenInvalidResponseStatus() throws {
    guard let urlSession = URLSessionFactory().create() else { XCTFail("URL should not be optional"); return }
    let client = try NetworkClient(urlSession: urlSession)
    let expectation = XCTestExpectation(description: "response")
    let status = 500
    setInvalidResponseStatusHandler(status: status)

    client.fetch(apiRequest: DummyRequest()) { receivedPhotos, error in
      defer {
        expectation.fulfill()
      }
      XCTAssertNotNil(error)
      guard case .status = error as? NetworkError else {
        XCTFail("The error is not the right type: \(String(describing: error))."); return
      }
      guard case .status(status: String(status)) = error as? NetworkError else {
        XCTFail("The http response status is wrong: \(status)."); return
      }
      XCTAssertNil(receivedPhotos)
    }

    wait(for: [expectation], timeout: 1)
  }
}

extension NetworkClientTests {
  private func setSuccessfulOneElementHandler() -> [PlaceholderPhoto]? {
    let photos = PlaceholderPhotosFactory().create()

    URLProtocolStub.handler = { request in
      let data = try JSONEncoder().encode(photos)
      let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: .none, headerFields: .none)!

      return (response, data)
    }

    return photos
  }

  private func setNoDataHandler() {
    URLProtocolStub.handler = { request in
      let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: .none, headerFields: .none)!

      return (response, .none)
    }
  }

  private func setNoResponseHandler() {
    let photos = PlaceholderPhotosFactory().create()

    URLProtocolStub.handler = { request in
      let data = try JSONEncoder().encode(photos)

      return (.none, data)
    }
  }

  private func setInvalidResponseStatusHandler(status: Int) {
    let photos = PlaceholderPhotosFactory().create()

    URLProtocolStub.handler = { request in
      let data = try JSONEncoder().encode(photos)
      let response = HTTPURLResponse(url: request.url!, statusCode: status, httpVersion: .none, headerFields: .none)!

      return (response, data)
    }
  }
}

class DummyRequest: APIRequest {
  typealias ResponseType = [PlaceholderPhoto]
  var request: URLRequest? { URLRequest(url: URL(string: "http://any-url.com")!) }
}

extension PlaceholderPhoto: Equatable {
  static public func == (lhs: PlaceholderPhoto, rhs: PlaceholderPhoto) -> Bool {
    lhs.title == rhs.title && lhs.url == rhs.url && lhs.thumbnailUrl == rhs.thumbnailUrl
  }
}
