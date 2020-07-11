//
//  Artist.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

class Artist: ObservableObject, Decodable, API {
	private static let myArtistID: Int = 59792
	static var endpoint: Endpoint = .artist(myArtistID)
	
	let name: String
	let id: UInt
	let realname: String
	let profile: String
	
	private init(name: String, id: UInt, realName: String, profile: String) {
		self.name = name
		self.id = id
		self.realname = realName
		self.profile = profile
	}
}


extension Artist {
	static let testData: Artist = Artist(name: "Bob Dylan", id: 59792, realName: "Robert Allen Zimmerman", profile: "Born: May 24, 1941, Duluth, Minnesota, USA; singer, songwriter, \"song and dance man\".")
}
