//
//  CollectionTests.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 14/07/2020.
//

import XCTest
@testable import AlbumTracker

class CollectionTests: XCTestCase {
	
	func testParsingSuccess() {
		let expectation = self.expectation(description: #function)
		Collection.fetch(endpoint: .collection(1), session: DummyURLSession.default) { (results) in
			switch results {
			case .success(let collection):
				XCTAssertTrue(collection.releases.count > 0)
				expectation.fulfill()
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}
		}
		self.waitForExpectations(timeout: 2) { (error) in
			XCTAssertNil(error)
		}
	}
	
	func testFailedRequest() {
		let expectation = self.expectation(description: #function)
		Collection.fetch(endpoint: .collection(1), session: DummyURLSession.failed) { (results) in
			switch results {
			case .failure(let error):
				XCTAssertNotNil(error)
				expectation.fulfill()
			case .success(let collection):
				XCTFail("Expected to throw error but found: \(collection)")
			}
		}
		self.waitForExpectations(timeout: 2) { (error) in
			XCTAssertNil(error)
		}
	}
	
}

