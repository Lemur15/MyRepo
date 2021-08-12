//
//  WelcomeDB.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation
import RealmSwift

public final class StoredWelcome: Object {
    
    @objc dynamic var base = ""
    @objc dynamic var name = ""
    @objc dynamic var visibility = 0
    @objc dynamic var dt = 0
    @objc dynamic var id = 0
    @objc dynamic var timezone = 0
    @objc dynamic var cod = 0
    
    dynamic var weather: WeatherDB?
    
    public convenience init(json: WelcomeJson) {
        
        self.init()
        
        self.base = json.base
        self.name = json.name
        self.visibility = json.visibility
        self.dt = json.dt
        self.timezone = json.timezone
        self.cod = json.cod
        self.id = json.id
        
        if let weather = json.weather {
            self.weather = WeatherDB(json: weather)
        }
    }
}
