//
//  ReleaseTests.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 14/07/2020.
//

import XCTest
@testable import AlbumTracker

class ReleaseTests: XCTestCase {
	func testParsingSuccess() {
		let expectation = self.expectation(description: #function)
		MainRelease.fetch(endpoint: .release(1), session: DummyURLSession.default) { (results) in
			switch results {
			case .success(let release):
				XCTAssertEqual(release.id, 4455)
				XCTAssertEqual(release.title, "The Freewheelin' Bob Dylan")
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
		MainRelease.fetch(endpoint: .release(1), session: DummyURLSession.failed) { (results) in
			switch results {
			case .failure(let error):
				XCTAssertNotNil(error)
				expectation.fulfill()
			case .success(let release):
				XCTFail("Expected to throw error but found: \(release)")
			}
		}
		self.waitForExpectations(timeout: 2) { (error) in
			XCTAssertNil(error)
		}
	}
}
