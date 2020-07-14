//
//  MainRelease.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import Foundation

final class MainRelease: Identifiable, ObservableObject, Decodable, API {
	
	let id: UInt
	let lowestPrice: Float
	let title: String
	let notes: String?
	
	private enum CodingKeys: String, CodingKey {
		case id
		case lowestPrice = "lowest_price"
		case title
		case notes = "notes_plaintext"
	}
	
	#if DEBUG
	init(title: String, notes: String) {
		self.id = UInt.random(in: 0...100)
		self.lowestPrice = Float.random(in: 0...100)
		self.title = title
		self.notes = notes
	}
	#endif
}

#if DEBUG
extension MainRelease {
	static let testData: MainRelease = MainRelease(title: "Bringing All Back Home", notes: "Some notes")
}
#endif
