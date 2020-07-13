//
//  Collection.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import Foundation

final class Collection: ObservableObject, Decodable, API {
	var releases: [Release]
	
	init(releases: [Release]) {
		self.releases = releases
	}
}

extension Collection {
	static let testData: Collection = Collection(releases: [Release].testData)
}
