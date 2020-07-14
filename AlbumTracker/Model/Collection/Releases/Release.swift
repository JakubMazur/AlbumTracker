//
//  Release.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 13/07/2020.
//

import Foundation
import RealmSwift

final class Release: Identifiable, ObservableObject, Decodable {
	
	let id: UInt
	let title: String
	let role: Role
	let type: ReleaseType
	let year: UInt
	private let thumb: String?
	let stats: Stats
	lazy var thumbImage: APIImage = APIImage(imageType: .primary, resourceURL: self.thumb)
	
	init(id: UInt, title: String, role: Role, year: UInt, thumb: String? = nil, stats: Stats = Stats.random, type: ReleaseType = .master) {
		self.id = id
		self.title = title
		self.role = role
		self.year = year
		self.thumb = thumb
		self.stats = stats
		self.type = type
	}
	
	init(persistanceObject: ReleasePersistance) {
		self.id = UInt(persistanceObject.releaseID) ?? 0
		self.title = persistanceObject.title
		#warning("Rest of properties not sync 👇")
		self.role = .main
		self.type = .master
		self.year = 0
		self.thumb = nil
		self.stats = Stats(community: Community.random)
	}
}

extension Release {
	enum Role: String, Decodable {
		case main = "Main"
	}
	
	enum ReleaseType: String, Decodable {
		case release
		case master
	}
}

@objc final class ReleasePersistance: RealmSwift.Object {
	@objc dynamic var releaseID: String = UUID().uuidString
	@objc dynamic var title: String = ""
	
	override static func primaryKey() -> String? {
		return "releaseID"
	}
	
	convenience init(release: Release) {
		self.init()
		self.releaseID = String(release.id)
		self.title = release.title
	}
}

extension Release {
	static let testData: Release = Release(id: 10, title: "Highway 61 Revisited", role: .main, year: 1965, thumb: "https://upload.wikimedia.org/wikipedia/en/9/95/Bob_Dylan_-_Highway_61_Revisited.jpg")
}

extension Array where Element == Release {
	static var testData: [Element] = [
		Element(id: 1, title: "Bob Dylan", role: .main, year: 1962, thumb: "https://upload.wikimedia.org/wikipedia/en/6/60/Bob_Dylan_-_Bob_Dylan.gif"),
		Element(id: 2, title: "The Freewheelin'", role: .main, year: 1963, thumb: "https://upload.wikimedia.org/wikipedia/en/d/d6/Bob_Dylan_-_The_Freewheelin%27_Bob_Dylan.jpg"),
		Element(id: 3, title: "The Times They Are a-Changin'", role: .main, year: 1964),
		Element(id: 4, title: "Another Side of Bob Dylan", role: .main, year: 1964, thumb: "https://upload.wikimedia.org/wikipedia/en/3/39/Bob_Dylan_-_Another_Side_of_Bob_Dylan.jpg"),
		Element(id: 5, title: "Bringing It All Back Home", role: .main, year: 1965),
		Element(id: 6, title: "Highway 61 Revisited", role: .main, year: 1965, thumb: "https://upload.wikimedia.org/wikipedia/en/9/95/Bob_Dylan_-_Highway_61_Revisited.jpg"),
		Element(id: 7, title: "Blonde on Blonde", role: .main, year: 1966),
		Element(id: 8, title: "John Wesley Harding", role: .main, year: 1967),
		Element(id: 9, title: "Nashville Skyline", role: .main, year: 1969, thumb: "https://upload.wikimedia.org/wikipedia/en/9/93/Bob_Dylan_-_Nashville_Skyline.jpg"),
	]
}
