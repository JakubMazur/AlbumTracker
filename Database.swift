//
//  Database.swift
//  AlbumTracker
//
//  Created by Jakub Mazur on 14/07/2020.
//

import Foundation
import RealmSwift

final class Database {
	private let realm: Realm
	
	init(realm: Realm? = nil) throws {
		if let realm = realm {
			self.realm = realm
		} else {
			self.realm = try Realm()
		}
	}
	
	func update<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) throws {
		let object = reverseTransformer(model)
		try realm.write {
			realm.add(object, update: .modified)
		}
	}
	
	func fetch<Model, RealmObject>(with request: FetchRequest<Model, RealmObject>) -> Model {
		let results = realm.objects(RealmObject.self)
		return request.transformer(results)
	}
	
	func storePersistently() throws {
		try realm.commitWrite()
	}
}
