//
//  DummyURLSession.swift
//  AlbumTrackerTests
//
//  Created by Jakub Mazur on 12/07/2020.
//

import Foundation
@testable import AlbumTracker

class DummyURLSession {
	enum State {
		case success
		case failed
	}
	
	let state: State
	
	init(state: State) {
		self.state = state
	}
	
	static let `default` = DummyURLSession(state: .success)
	static let failed = DummyURLSession(state: .failed)
	let simulatedNetworkConnectionDelay: TimeInterval = 0.1
}

extension DummyURLSession: EndpointConnectable {
	
	func dataTaskPublisher(for url: URLRequest) -> URLSession.DataTaskPublisher {
		return URLSession.DataTaskPublisher(request: url, session: URLSession.shared)
	}
	
	func dataTask(with endpoint: Endpoint, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask {
		DispatchQueue.main.asyncAfter(deadline: .now() + self.simulatedNetworkConnectionDelay) {
			let data = self.getSuccessOutput(for: endpoint)
			switch self.state {
			case .success:
				completionHandler(data,nil,nil)
			case .failed:
				completionHandler(nil,nil,NSError.networkingDefault)
			}
		}
		return DummyURLSessionDataTask()
	}
	
	private func getSuccessOutput(for endpoint: Endpoint) -> Data {
		let path = Bundle(for: Self.self).path(forResource: endpoint.dummyResponseFileName, ofType: "json", inDirectory: "dummyJSONs")
		let url = URL(fileURLWithPath: path!)
		let data: Data = try! Data(contentsOf: url)
		return data
	}
}

extension Endpoint {
	var dummyResponseFileName: String {
		switch self {
		case .artist: return "artist"
		case .custom, .subpath: return ""
		}
	}
}

class DummyURLSessionDataTask: URLSessionDataTask {
	override func resume() { }
}
