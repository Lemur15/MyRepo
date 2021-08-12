//
//  WeatherJson.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation

public struct WeatherJson: Codable {
    
    var id: Int
    var main, weatherDescription, icon : String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        weatherDescription = try container.decode(String.self, forKey: .weatherDescription)
        icon = try container.decode(String.self, forKey: .icon)
    }
    
    public init(dbModel: WeatherDB) {
        
        self.id = dbModel.id
        self.main = dbModel.main
        self.weatherDescription = dbModel.description
        self.icon = dbModel.icon
    }
    
    init(id: Int, main: String, weatherDescription: String, icon: String ) {
        
        self.id = id
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
}
