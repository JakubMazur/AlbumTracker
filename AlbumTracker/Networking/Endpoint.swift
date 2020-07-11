//
//  Endpoint.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation


enum Endpoint {
	case artist(Int)
	case album(Int)
	case subpath(String)
	case custom(String)
	
	private var relative: String? {
		switch self {
		case .artist(let identifier): return "/artists/\(identifier)"
		case .album(let identifier): return "/album/\(identifier)"
		case .subpath(let stringURLSub): return stringURLSub
		case .custom: return nil
		}
	}
	
	private var url: URL? {
		if let rel = self.relative {
			return URL(string: rel, relativeTo: Networking.base)
		} else {
			switch self {
			case .custom(let urlString): return URL(string: urlString)
			default: return nil
			}
		}
	}
	
	var request: URLRequest? {
		var request = URLRequest(url: self.url)
		request?.setValue("AlbumTracker/0.1 +https://kettu.pl", forHTTPHeaderField: "User-Agent")
		if let credentials = self.credentials() {
			request?.setValue("Discogs key=\(credentials.key), secret=\(credentials.secret)", forHTTPHeaderField: "Authorization")
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

struct APICredentials: Decodable {
	let key: String
	let secret: String
}
