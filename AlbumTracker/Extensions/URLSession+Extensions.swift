//
//  URLSession+Extensions.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 12/07/2020.
//

import Foundation

extension URLSession {
	func dataTask(with endpoint: Endpoint, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask {
		let request = try endpoint.getRequest()
		return self.dataTask(with: request, completionHandler: completionHandler)
	}
}

extension URLSession: EndpointConnectable { }
