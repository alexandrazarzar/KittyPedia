//
//  APIServiceTests.swift
//  Cats
//
//  Created by avz on 05/02/25.
//

import XCTest
@testable import Cats

final class APIServiceTests: XCTestCase {
    var apiService: APIService!
    var mockSession: URLSession!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)

        apiService = APIService(baseURL: "https://example.com", apiKey: "test_api_key", session: mockSession)
    }

    override func tearDown() {
        apiService = nil
        mockSession = nil
        MockURLProtocol.mockResponse = nil
    }

    func testFetchData_ShouldReturnDecodedData() async throws {
        let jsonResponse = """
        {
            "id": "1",
            "name": "Siberian",
            "temperament": "Playful",
            "origin": "Russia",
            "lifeSpan": "12-15",
            "weight": { "imperial": "11-17", "metric": "5-8" },
            "description": "A friendly and intelligent cat breed.",
            "adaptability": 5,
            "affectionLevel": 5,
            "childFriendly": 5,
            "dogFriendly": 4,
            "energyLevel": 4,
            "intelligence": 5,
            "socialNeeds": 4,
            "strangerFriendly": 4,
            "vocalisation": 3,
            "image": null
        }
        """.data(using: .utf8)!

        let response = HTTPURLResponse(url: URL(string: "https://example.com/breeds")!,
                                       statusCode: 200, httpVersion: nil, headerFields: nil)

        MockURLProtocol.mockResponse = (jsonResponse, response, nil)

        let result: BreedResponse = try await apiService.fetchData(from: "/breeds")

        XCTAssertEqual(result.name, "Siberian")
        XCTAssertEqual(result.temperament, "Playful")
        XCTAssertEqual(result.origin, "Russia")
    }

    func testFetchData_ShouldThrowDecodingError() async {
        let invalidJson = "{ invalid json }".data(using: .utf8)!

        let response = HTTPURLResponse(url: URL(string: "https://example.com/breeds")!,
                                       statusCode: 200, httpVersion: nil, headerFields: nil)

        MockURLProtocol.mockResponse = (invalidJson, response, nil)

        do {
            let _: BreedResponse = try await apiService.fetchData(from: "/breeds")
            XCTFail("Expected decoding error but got success")
        } catch let error as ServiceError {
            if case .decodingFailure(_) = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Expected decodingFailure but got \(error)")
            }
        } catch {
            XCTFail("Unexpected error)")
        }
    }

    func testFetchData_ShouldThrowInvalidResponseError() async {
        let response = HTTPURLResponse(url: URL(string: "https://example.com/breeds")!,
                                       statusCode: 404, httpVersion: nil, headerFields: nil)

        MockURLProtocol.mockResponse = (nil, response, nil)

        do {
            let _: BreedResponse = try await apiService.fetchData(from: "/breeds")
            XCTFail("Expected invalid response error but got success")
        } catch let error as ServiceError {
            XCTAssertEqual(error.description, "Invalid response from server")
        } catch {
            XCTFail("Unexpected error)")
        }
    }

    func testFetchData_ShouldThrowNetworkError() async {
        let networkError = NSError(domain: "NSURLErrorDomain", code: -1009, userInfo: nil)

        MockURLProtocol.mockResponse = (nil, nil, networkError)

        do {
            let _: BreedResponse = try await apiService.fetchData(from: "/breeds")
            XCTFail("Expected network error but got success")
        } catch {
            XCTAssertTrue(error is NSError, "Expected network error but got \(error)")
        }
    }
}

class MockURLProtocol: URLProtocol {
    static var mockResponse: (Data?, HTTPURLResponse?, Error?)?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let response = MockURLProtocol.mockResponse {
            if let httpResponse = response.1 {
                client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
            }
            if let data = response.0 {
                client?.urlProtocol(self, didLoad: data)
            }
            if let error = response.2 {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
