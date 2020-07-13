//
//  APIImage.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation
import UIKit
import Combine

final class APIImage: ObservableObject, Decodable, API {
	
	private var subscription: AnyCancellable?
	@Published private(set) var image: UIImage?
	
	let imageType: ImageType
	private let resourceURL: String?
	
	enum CodingKeys: String, CodingKey {
		case imageType = "type"
		case resourceURL = "resource_url"
	}
	
	init(imageType: ImageType, resourceURL: String?) {
		self.imageType = imageType
		self.resourceURL = resourceURL
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		imageType = try container.decode(ImageType.self, forKey: .imageType)
		resourceURL = try container.decode(String.self, forKey: .resourceURL)
	}
	
	func load() {
		guard let request = try? Endpoint.custom(self.resourceURL).getRequest() else { return }
		subscription = APIImage.session.dataTaskPublisher(for: request).map { UIImage(data: $0.data) }.replaceError(with: nil).receive(on: DispatchQueue.main).assign(to: \.image, on: self)
	}

	func cancel() {
		subscription?.cancel()
	}
}

extension APIImage {
	enum ImageType: String, Decodable {
		case primary
		case secondary
	}
}

extension APIImage {
	static let testData: APIImage = APIImage(imageType: .primary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Joan_Baez_Bob_Dylan_crop.jpg/220px-Joan_Baez_Bob_Dylan_crop.jpg")
}

extension Array where Element == APIImage {
	static let testData: [APIImage] = [
		Element(imageType: .primary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Joan_Baez_Bob_Dylan_crop.jpg/220px-Joan_Baez_Bob_Dylan_crop.jpg"),
		Element(imageType: .primary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Bob_Dylan_-_Azkena_Rock_Festival_2010_2.jpg/220px-Bob_Dylan_-_Azkena_Rock_Festival_2010_2.jpg"),
		Element(imageType: .primary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Bob-Dylan-arrived-at-Arlanda-surrounded-by-twenty-bodyguards-and-assistants-391770740297_%28cropped%29.jpg/220px-Bob-Dylan-arrived-at-Arlanda-surrounded-by-twenty-bodyguards-and-assistants-391770740297_%28cropped%29.jpg"),
		Element(imageType: .secondary, resourceURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Bob_Dylan_in_Toronto.jpg/220px-Bob_Dylan_in_Toronto.jpg")
	]
}
