//
//  Endpoint.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 11/07/2020.
//

import XCTest
@testable import AlbumTracker

class EndpointTests: XCTestCase {
	
	enum HTTPField: String, CaseIterable {
		case userAgent = "User-Agent"
		case accept = "Accept"
		case auth = "Authorization"
		
		var expectedValues: [String] {
			switch self {
			case .accept: return ["plaintext+json"]
			case .userAgent: return ["AlbumTracker", "kettu.pl"]
			case .auth: return ["Discogs", "key", "secret"]
			}
		}
	}
	
	func testRequestSetupHTTPFields() {
		let artist = Endpoint.artist(1)
		let request = try! artist.getRequest()
		HTTPField.allCases.forEach {
			let field = $0
			let givenValue = request.value(forHTTPHeaderField: field.rawValue)!
			field.expectedValues.forEach {
				XCTAssertTrue(givenValue.contains($0))
			}
		}
	}
	
	func testCustomCase() {
		XCTAssertNoThrow(try Endpoint.custom("https://jkmazur.pl").getRequest())
		XCTAssertThrowsError(try Endpoint.custom(nil).getRequest())
	}
	
	func testSubpath() {
		let invalidPath = Endpoint.subpath("\\\\something")
		XCTAssertThrowsError(try invalidPath.getRequest())
		let validSubPath = Endpoint.subpath("/something")
		XCTAssertNoThrow(try validSubPath.getRequest())
	}
	
}
