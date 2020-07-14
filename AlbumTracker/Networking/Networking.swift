//
//  Networking.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

struct Networking {
	typealias NetworkResult<T> = (Result<T,Error>)
	
	static let base: URL = URL(string: "https://api.discodsadsags.com/")!
}

extension NSError {
	private convenience init(errorDescription: String) {
		self.init(domain: "pl.jkmazur.AlbumTracker", code: 101, userInfo: [ NSLocalizedDescriptionKey: errorDescription])
	}
	
	static var networkingDefault: Error { NSError(errorDescription: "Request canot be made") }
	static var persistantStorageNotFound: Error { NSError(errorDescription: "Do not found in persistance storage") }
	static var notValidRequest: Error { NSError(errorDescription: "Valid url to this endpoint cannot be found") }
	static var notValidURL: Error { NSError(errorDescription: "Valid request to this endpoint cannot be found") }
	static var requestEmptyData: Error { NSError(errorDescription: "Data from the response does not contain a valid object") }
}
