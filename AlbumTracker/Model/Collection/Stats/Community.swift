//
//  Community.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import Foundation

final class Community: Identifiable, ObservableObject, Decodable {
	let want: UInt
	let have: UInt
	
	private enum CodingKeys: String, CodingKey {
		case want = "in_wantlist"
		case have = "in_collection"
	}
	
	init(want: UInt, have: UInt) {
		self.want = want
		self.have = have
	}
}

extension Community {
	static let random: Community = Community(want: UInt.random(in: 0...10_000), have: UInt.random(in: 0...10_000))
}
