//
//  ViewController.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 11.08.2021.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet private weak var getDataButton: UIButton!
    
    @IBOutlet private weak var anyLabel: UILabel!
    
    private var weatherModels = [WeatherJson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getDataButtonTapped(_ sender: Any) {
        fetchAllWeathers()
    }
    
    func fetchAllWeathers() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?id=8261417&appid=b636992ae3b73b91aef4efedf2b2ad42"
        
        if RealmDataBase().realm.isEmpty {
            self.createDefaultDatabase()
        } else {
            
        Alamofire.request(url).responseData { dataResponse in
            
            if let err = dataResponse.error {
                print("Server error is: ", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(WelcomeJson.self, from: data)
                
                guard let weatherModel = searchResult.weather else { return }
                
                self.weatherModels.append(weatherModel)
                self.saveCodablaModelToDatabase(json: weatherModel)
            }
            catch let decodeError {
                print("Failed to decode", decodeError)
            }
            self.anyLabel.text = RealmDataBase().realmWeatherModel.first.
//            self.anyLabel.text = self.realmModel.first?.main
        }
        }
    }
    
    private func saveCodablaModelToDatabase(json: WeatherJson) {
        let realmDataBase = RealmDataBase()
        do {
            try realmDataBase.realm.write() {
                let newDB = WeatherDB(json: json)
                realmDataBase.realm.add(newDB)
            }
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            assertionFailure(message)
            preconditionFailure(message)
        }
        
        realmDataBase.realmWeatherModel = realmDataBase.realm.objects(WeatherDB.self)
    }
    
    private func createDefaultDatabase() {
        
        let realmDataBase = RealmDataBase()
            do {
                try realmDataBase.realm.write() {
                    
                   let defaultWeatherJson = WeatherJson(id: 11, main: "Mock", weatherDescription: "This is mock data", icon: " ")
                    let defaultDatabase = WeatherDB(json: defaultWeatherJson)
                    realmDataBase.realm.add(defaultDatabase)
                }
            } catch {
                let message: String = "Unable to create realm instance \(error)"
                assertionFailure(message)
                preconditionFailure(message)
            }
        }
}
