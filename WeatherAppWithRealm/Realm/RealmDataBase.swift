//
//  Realm.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation
import RealmSwift

final class RealmDataBase {
    
    lazy var shared: Realm = {
        do {
            return try Realm()
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            assertionFailure(message)
            preconditionFailure(message)
        }
    }()
    
    lazy var realmWeatherModel: Results<WeatherDB> = { self.shared.objects(WeatherDB.self)}()
}
