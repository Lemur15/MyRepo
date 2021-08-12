//
//  WeatherRealmModel.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 11.08.2021.
//

import Foundation
import RealmSwift

public final class WeatherDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var main = ""
    @objc dynamic var weatherDescription = ""
    @objc dynamic var icon = ""
    
    public convenience init (json: WeatherJson) {
        self.init()
        self.id = json.id
        self.main = json.main
        self.weatherDescription = json.weatherDescription
        self.icon = json.icon
    }
}
