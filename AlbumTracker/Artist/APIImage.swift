//
//  APIImage.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

final class APIImage: ObservableObject, Decodable {
	let imageType: ImageType
	private let resourceURL: String?
	var url: URL? { URL(string: resourceURL) }
	
	enum CodingKeys: String, CodingKey {
		case imageType = "type"
		case resourceURL = "resource_url"
	}
	
	private init(imageType: ImageType, resourceURL: String?) {
		self.imageType = imageType
		self.resourceURL = resourceURL
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		imageType = try container.decode(ImageType.self, forKey: .imageType)
		resourceURL = try container.decode(String.self, forKey: .resourceURL)
	}
}


extension APIImage {
	enum ImageType: String, Decodable {
		case primary
		case secondary
	}
}

extension APIImage {
	static let testData: [APIImage] = [
		.init(imageType: .primary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Joan_Baez_Bob_Dylan_crop.jpg/220px-Joan_Baez_Bob_Dylan_crop.jpg"),
		.init(imageType: .primary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Bob_Dylan_-_Azkena_Rock_Festival_2010_2.jpg/220px-Bob_Dylan_-_Azkena_Rock_Festival_2010_2.jpg"),
		.init(imageType: .secondary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Bob-Dylan-arrived-at-Arlanda-surrounded-by-twenty-bodyguards-and-assistants-391770740297_%28cropped%29.jpg/220px-Bob-Dylan-arrived-at-Arlanda-surrounded-by-twenty-bodyguards-and-assistants-391770740297_%28cropped%29.jpg"),
		.init(imageType: .secondary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Bob_Dylan_in_Toronto.jpg/220px-Bob_Dylan_in_Toronto.jpg")
	]
}
