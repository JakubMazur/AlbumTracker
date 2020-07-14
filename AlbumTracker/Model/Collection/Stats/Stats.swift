//
//  Stats.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import Foundation

final class Stats: Identifiable, ObservableObject, Decodable {
	let community: Community
	
	init(community: Community) {
		self.community = community
	}
}

extension Stats {
	static let random: Stats = Stats(community: Community.random)
}
