//
//  URL+Extensions.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

extension URL {
	init?(string: String?) {
		guard let string = string else { return nil }
		self.init(string: string)
	}
}
