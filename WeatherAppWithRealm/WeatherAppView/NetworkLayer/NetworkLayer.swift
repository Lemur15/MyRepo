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
    
    func fetchAllWeathers(completion: @escaping (Swift.Result<WelcomeJson, Error>) -> Void) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?id=8261417&appid=b636992ae3b73b91aef4efedf2b2ad42"
        
        Alamofire.request(url).responseJSON { response in
            
            if let err = response.error {
                print("Server error is: ", err)
                return
            }
            guard let data = response.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(WelcomeJson.self, from: data)
                
                completion(.success(searchResult))
            }
            catch {
                completion(.failure(error))
                
            }
        }
    }
}
