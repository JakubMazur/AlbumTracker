//
//  Artist.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: RealmSwift.Object> {
	let transformer: (Results<RealmObject>) -> Model
	// skippting sorting and predicates for now
}

final class Artist: Identifiable, ObservableObject, Decodable, API {
	
	static var dbIdentifier: String = "artists"
	
	let id: UInt
	let name: String
	let realName: String
	let profile: String
	let images: [APIImage]
	var masterReleases: [Release]?
	
	private init(name: String, id: UInt, realName: String, profile: String, images: [APIImage]) {
		self.name = name
		self.id = id
		self.realName = realName
		self.profile = profile
		self.images = images
		self.masterReleases = nil
	}
	
	fileprivate init(persistanceObject: ArtistPersistance) {
		self.id = UInt(persistanceObject.artistID) ?? 0
		self.name = persistanceObject.name
		self.realName = persistanceObject.realName
		self.profile = persistanceObject.profile
		self.images = []
		self.masterReleases = persistanceObject.masterReleases.compactMap { Release(persistanceObject: $0) }
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
		masterReleases = nil
	}
}

extension Artist {
	func save() throws {
		let database = try Database(realm: nil)
		try database.update(model: self, with: ArtistPersistance.init)
	}
	
	#warning("this should be fetch(id: ...) and predicate on fetchrequest lvl")
	static func fetch() throws -> [Artist]? {
		let database = try Database(realm: nil)
		let request = FetchRequest<[Artist], ArtistPersistance> { (results) -> [Artist] in
			results.map { Artist(persistanceObject: $0) }
		}
		let fethed = database.fetch(with: request)
		return fethed
	}
}

final class ArtistPersistance: RealmSwift.Object {
	@objc dynamic var artistID: String = UUID().uuidString
	@objc dynamic var name: String = ""
	@objc dynamic var realName: String = ""
	@objc dynamic var profile: String = ""
	let masterReleases: List<ReleasePersistance> = List<ReleasePersistance>()
	
	override static func primaryKey() -> String? {
		return "artistID"
	}
	
	convenience init(artist: Artist) {
		self.init()
		self.artistID = String(artist.id)
		self.name = artist.name
		self.realName = artist.realName
		let releases = artist.masterReleases?.compactMap { ReleasePersistance(release: $0) } ?? []
		self.masterReleases.append(objectsIn: releases)
		self.profile = artist.profile
	}
}

extension Artist {
	static let testData: Artist = Artist(name: "Bob Dylan", id: 59792, realName: "Robert Allen Zimmerman", profile: "Born: May 24, 1941, Duluth, Minnesota, USA; singer, songwriter, \"song and dance man\".\r\nInducted into Songwriters Hall of Fame in 1982 and the Rock And Roll Hall of Fame in 1988 (Performer). Winner of the 2016 Nobel Prize in literature.\r\nHis first marriage was to Sara Dylan (November 1965 - divorced June 1977), together they have five children, including Jesse Dylan and Jakob Dylan. His second marriage was to Carolyn Dennis (4 June 1986 - divorced 7 August 1990).", images: [APIImage].testData)
}
