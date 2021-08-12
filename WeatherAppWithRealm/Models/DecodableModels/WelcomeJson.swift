//
//  WelcomeJson.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation

public struct WelcomeJson: Codable {
    
    var base: String
    var visibility: Int
    var dt: Int
    var timezone, id: Int
    var name: String
    var cod: Int
    var weather: WeatherJson?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        
        case base = "base"
        case visibility = "visibility"
        case dt = "dt"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
        case weather = "weather"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        base = try container.decode(String.self, forKey: .base)
        visibility = try container.decode(Int.self, forKey: .visibility)
        dt = try container.decode(Int.self, forKey: .dt)
        timezone = try container.decode(Int.self, forKey: .timezone)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        cod = try container.decode(Int.self, forKey: .cod)
        weather = try container.decode(WeatherJson.self, forKey: .weather)
    }
    
    init(base: String, visibility: Int, dt: Int, timezone: Int, id: Int, name: String, cod: Int, weather: WeatherJson?) {
        
        self.base = base
        self.visibility = visibility
        self.dt = dt
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
        self.weather = weather
    }
    
    public init(dbModel: StoredWelcome) {
        
        self.base = dbModel.base
        self.visibility = dbModel.visibility
        self.dt = dbModel.dt
        self.cod = dbModel.cod
        self.timezone = dbModel.timezone
        self.id = dbModel.id
        self.name = dbModel.name
        
        if let weather = dbModel.weather {
            self.weather = WeatherJson(dbModel: weather)
        }
    }
}
