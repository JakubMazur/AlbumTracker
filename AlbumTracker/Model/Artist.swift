//
//  Artist.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

import RealmSwift

final class ArtistObject: Object {
	dynamic var identifier: String = UUID().uuidString
	dynamic var name: String = ""
	dynamic var realName: String = ""
	dynamic var profile: String = ""
}

final class Artist: Identifiable, ObservableObject, Decodable, API {
	
	let id: UInt
	let name: String
	let realName: String
	let profile: String
	let images: [APIImage]
	
	private init(name: String, id: UInt, realName: String, profile: String, images: [APIImage]) {
		self.name = name
		self.id = id
		self.realName = realName
		self.profile = profile
		self.images = images
	}
	
	lazy var primaryImage: APIImage? = {
		self.images.filter { $0.imageType == .primary }.first
	}()
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case realName = "realname"
		case profile = "profile_plaintext"
		case images
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UInt.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		realName = try container.decode(String.self, forKey: .realName)
		profile = try container.decode(String.self, forKey: .profile)
		images = try container.decode([APIImage].self, forKey: .images)
	}
}


extension Artist {
	static let testData: Artist = Artist(name: "Bob Dylan", id: 59792, realName: "Robert Allen Zimmerman", profile: "Born: May 24, 1941, Duluth, Minnesota, USA; singer, songwriter, \"song and dance man\".\r\nInducted into Songwriters Hall of Fame in 1982 and the Rock And Roll Hall of Fame in 1988 (Performer). Winner of the 2016 Nobel Prize in literature.\r\nHis first marriage was to Sara Dylan (November 1965 - divorced June 1977), together they have five children, including Jesse Dylan and Jakob Dylan. His second marriage was to Carolyn Dennis (4 June 1986 - divorced 7 August 1990).", images: [APIImage].testData)
}
