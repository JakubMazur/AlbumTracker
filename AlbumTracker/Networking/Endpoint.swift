//
//  Endpoint.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

protocol EndpointConnectable {
	func dataTask(with endpoint: Endpoint, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask
	func dataTaskPublisher(for url: URLRequest) -> URLSession.DataTaskPublisher
}

enum Endpoint {
	case artist(Int)
	case subpath(String)
	case custom(String?)
	
	private var relative: String? {
		switch self {
		case .artist(let identifier): return "/artists/\(identifier)"
		case .subpath(let stringURLSub): return stringURLSub
		case .custom: return nil
		}
	}
	
	private func getUrl() throws -> URL {
		let url: URL?
		switch self {
		case .custom(let urlString):
			url = URL(string: urlString)
		default:
			if let relative = self.relative {
				url = URL(string: relative, relativeTo: Networking.base)
			} else {
				url = nil
			}
		}
		if let url = url {
			return url
		} else {
			throw NSError.notValidURL
		}
	}
	
	func getRequest() throws -> URLRequest {
		let url = try self.getUrl()
		var request = URLRequest(url: url)
		request.setValue("AlbumTracker/0.1 +https://kettu.pl", forHTTPHeaderField: "User-Agent")
		request.setValue("application/vnd.discogs.v2.plaintext+json", forHTTPHeaderField: "Accept")
		if let credentials = self.credentials() {
			request.setValue("Discogs key=\(credentials.key), secret=\(credentials.secret)", forHTTPHeaderField: "Authorization")
		}
		return request
	}

	private func credentials() -> APICredentials? {
		guard let credentialFilePath = Bundle.main.path(forResource: "credentials", ofType: "json"),
			  let data = try? Data(contentsOf: URL(fileURLWithPath: credentialFilePath)) else {
			return nil
		}
		return try? JSONDecoder().decode(APICredentials.self, from: data)
	}
}
