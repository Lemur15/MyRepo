//
//  WeatherModel.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 11.08.2021.
//

import Foundation
import SwiftyJSON


struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    init(json: JSON) {
        self.main = json["main"].stringValue
        self.weatherDescription = json["description"].stringValue
        self.icon = json["icon"].stringValue
        self.id = json["id"].intValue
    }
}

