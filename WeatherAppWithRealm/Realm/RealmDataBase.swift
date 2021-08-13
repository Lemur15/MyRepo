//
//  Realm.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation
import RealmSwift

final class RealmDataBase {
    
    lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            assertionFailure(message)
            preconditionFailure(message)
        }
    }()
    
    lazy var realmWeatherModel: Results<WeatherDB> = { self.realm.objects(WeatherDB.self)}()
    
    func deleteAllObjects() {
        do {
            try realm.write() {
                realm.deleteAll()
            }
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            assertionFailure(message)
            preconditionFailure(message)
        }
    }
    
     func saveCodablaModelToDatabase(json: WeatherJson) {
        do {
            try realm.write() {
                let newDB = WeatherDB(json: json)
                realm.add(newDB)
            }
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            assertionFailure(message)
            preconditionFailure(message)
        }
        
        self.realmWeatherModel = realm.objects(WeatherDB.self)
    }
    
    func getObject(completion: @escaping (String?) -> Void) {
        let objects = realm.objects(WeatherDB.self)
        completion(objects.first?.main)
    }
    
    var dataBaseIsEmpty: Bool {
        realm.objects(WeatherDB.self).isEmpty
    }
    
}
