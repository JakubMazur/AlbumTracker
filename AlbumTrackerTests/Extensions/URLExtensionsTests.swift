//
//  URLExtensionsTests.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 12/07/2020.
//

import XCTest
@testable import AlbumTracker

class URLExtensionsTests: XCTestCase {
	
	func testOptionalInitializer() {
		XCTAssertNotNil(URL(string: "https://jkmazur.pl"))
		XCTAssertNil(URL(string: nil))
	}
}
