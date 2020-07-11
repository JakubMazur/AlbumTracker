//
//  APICredentials.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

struct APICredentials: Decodable {
	let key: String
	let secret: String
}
