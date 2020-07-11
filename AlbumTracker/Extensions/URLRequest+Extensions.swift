//
//  URLRequest+Extensions.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

extension URLRequest {
	init?(url: URL?) {
		guard let url = url else { return nil }
		self.init(url: url)
	}
}
