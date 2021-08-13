//
//  WeatherAppInteractor.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation
import UIKit
import Alamofire

final class NetworkLayer {
    
    static var shared: NetworkLayer =  {
        return NetworkLayer()
    }()
    
    func fetchAllWeathers() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?id=8261417&appid=b636992ae3b73b91aef4efedf2b2ad42"
        
        let realmDataBase = RealmDataBase()
        
        if realmDataBase.realm.objects(WeatherDB.self).isEmpty {
            Alamofire.request(url).responseJSON { response in
                
                if let err = response.error {
                    print("Server error is: ", err)
                    return
                }
                
                guard let data = response.data else { return }
                do {
                    let searchResult = try JSONDecoder().decode(WelcomeJson.self, from: data)
                    guard let weatherModels = searchResult.weather else { return }
                    for weather in weatherModels {
                        realmDataBase.saveCodablaModelToDatabase(json: weather)
                    }
                }
                catch let decodeError {
                    print("Failed to decode", decodeError)
                }
            }
        }
        else {
            realmDataBase.realm.objects(WeatherDB.self)
        }
    }
}
