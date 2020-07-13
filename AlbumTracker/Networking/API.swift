//
//  API.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 11/07/2020.
//

import Foundation

protocol API: Decodable {
	static var session: EndpointConnectable { get }
}

extension API {
	static var session: EndpointConnectable {
		return URLSession.shared
	}
}

extension API {
	static func fetch(endpoint: Endpoint, session: EndpointConnectable? = nil, _ completion: @escaping(Result<Self,Error>) -> Void)  {
		let session: EndpointConnectable = session ?? Self.session
		var completionHandler: Result<Self,Error> = .failure(NSError.networkingDefault) {
			didSet {
				DispatchQueue.main.async {
					completion(completionHandler)
				}
			}
		}
		Self.fetch(endpoint, session: session) { (result) in
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
	
	private static func fetch(_ endpoint: Endpoint, session: EndpointConnectable, _ completion:@escaping(Result<Data,Error>) -> Void) {
		var result: Result<Data,Error> = .failure(NSError.networkingDefault) {
			didSet {
				DispatchQueue.main.async {
					completion(result)
				}
			}
		}
		do {
			let dataTask = try session.dataTask(with: endpoint) { (data, response, error) in
				guard let data = data else {
					result = .failure(NSError.requestEmptyData)
					return
				}
				result = .success(data)
			}
			dataTask.resume()
		} catch {
			result = .failure(error)
			return
		}
	}
}
