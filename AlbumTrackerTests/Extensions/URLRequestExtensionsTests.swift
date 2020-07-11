//
//  URLRequestExtensionsTests.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 11/07/2020.
//

import XCTest
@testable import AlbumTracker

class URLRequestExtensionsTests: XCTestCase {

	func testOptionalInitializer() {
		let url: URL = URL(string: "https://jkmazur.pl")!
		XCTAssertNotNil(URLRequest(url: url))
		XCTAssertNil(URLRequest(url: nil))
	}

}
