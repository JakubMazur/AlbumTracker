//
//  Release.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import Foundation

final class Release: Identifiable, ObservableObject, Decodable {
	
	let id: UInt
	let title: String
	let role: Role
	let year: UInt
	private let thumb: String?
	
	init(id: UInt, title: String, role: Role, year: UInt, thumb: String? = nil) {
		self.id = id
		self.title = title
		self.role = role
		self.year = year
		self.thumb = thumb
	}
}

extension Release {
	enum Role: String, Decodable {
		case main = "Main"
	}
}

extension Release {
	static let testData: Release = Release(id: 10, title: "Highway 61 Revisited", role: .main, year: 1965)
}

extension Array where Element == Release {
	static var testData: [Element] = [
		Element(id: 1, title: "Bob Dylan", role: .main, year: 1962),
		Element(id: 2, title: "The Freewheelin'", role: .main, year: 1963),
		Element(id: 3, title: "The Times They Are a-Changin'", role: .main, year: 1964),
		Element(id: 4, title: "Another Side of Bob Dylan", role: .main, year: 1964),
		Element(id: 5, title: "Bringing It All Back Home", role: .main, year: 1965),
		Element(id: 6, title: "Highway 61 Revisited", role: .main, year: 1965),
		Element(id: 7, title: "Blonde on Blonde", role: .main, year: 1966),
		Element(id: 8, title: "John Wesley Harding", role: .main, year: 1967),
		Element(id: 9, title: "Nashville Skyline", role: .main, year: 1969),
	]
}
