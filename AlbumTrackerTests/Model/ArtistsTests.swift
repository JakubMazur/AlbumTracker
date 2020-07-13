//
//  ArtistsTests.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 12/07/2020.
//

import XCTest
@testable import AlbumTracker

class ArtistsTests: XCTestCase {
	
	func testParsingSuccess() {
		let expectation = self.expectation(description: #function)
		Artist.fetch(endpoint: .artist(1), session: DummyURLSession()) { (results) in
			switch results {
			case .success(let artist):
				XCTAssertEqual(artist.name, "Bob Dylan")
				XCTAssertTrue(artist.images.count > 0)
				expectation.fulfill()
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}
		}
		self.waitForExpectations(timeout: 2) { (error) in
			XCTAssertNil(error)
		}
	}
	
}
