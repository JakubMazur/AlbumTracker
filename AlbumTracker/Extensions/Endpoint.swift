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
		return URLRequest(url: self.url)
	}
}
