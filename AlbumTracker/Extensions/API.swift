//
//  API.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

protocol API: Decodable {
	static var endpoint: Endpoint { get }
}

extension API {
	static func fetch(_ completion: @escaping(Result<Self,Error>) -> Void) {
		var completionHandler: Result<Self,Error> = .failure(NSError.networkingDefault) {
			didSet {
				DispatchQueue.main.async {
					completion(completionHandler)
				}
			}
		}
		Self.fetch(self.endpoint) { (result) in
			switch result {
			case .success(let data):
				do {
					let decoded = try JSONDecoder().decode(Self.self, from: data)
					completionHandler = .success(decoded)
				} catch {
					completionHandler = .failure(error)
				}
			case .failure(let error):
				completionHandler = .failure(error)
			}
		}
	}
	
	static func fetch(_ endpoint: Endpoint, _ completion:@escaping(Result<Data,Error>) -> Void) {
		var result: Result<Data,Error> = .failure(NSError.networkingDefault) {
			didSet {
				DispatchQueue.main.async {
					completion(result)
				}
			}
		}
		guard let request = endpoint.request else {
			result = .failure(NSError.notValidEndpoint)
			return
		}
		let session: URLSession = URLSession(configuration: .default)
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			guard let data = data else {
				result = .failure(NSError.requestEmptyData)
				return
			}
			result = .success(data)
		}
		dataTask.resume()
	}
}