//
//  Artist.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

final class Artist: ObservableObject, Decodable, API {
	
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
	static let testData: Artist = Artist(name: "Bob Dylan", id: 59792, realName: "Robert Allen Zimmerman", profile: "Born: May 24, 1941, Duluth, Minnesota, USA; singer, songwriter, \"song and dance man\".", images: [APIImage].testData)
}
