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
    
    private var weatherModels = [WelcomeJson]()
    
    lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            assertionFailure(message)
            preconditionFailure(message)
        }
    }()
    
    lazy var realmModel: Results<WeatherDB> = { self.realm.objects(WeatherDB.self)}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getDataButtonTapped(_ sender: Any) {
        fetchAllWeathers()
    }
    
    func fetchAllWeathers() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?id=8261417&appid=b636992ae3b73b91aef4efedf2b2ad42"
        
        Alamofire.request(url).responseData { dataResponse in
            
            if let err = dataResponse.error {
                print("Server error is: ", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(WelcomeJson.self, from: data)
                guard let weatherModel = searchResult.weather else { return }
                self.defaultWeatherModels(json: weatherModel)
                self.weatherModels.append(searchResult)
            }
            catch let decodeError {
                print("Failed to decode", decodeError)
            }
            self.anyLabel.text = self.realmModel.first?.main
        }
    }
    
    
    
    private func defaultWeatherModels(json: WeatherJson) {
        
        if realmModel.isEmpty {
            do {
                try realm.write() {
                    let defaultValues = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids"]
                    
                    for weather in defaultValues {
                        let newDBModel = WeatherDB()
                        newDBModel.weatherDescription = weather
                        self.realm.add(newDBModel)
                    }
                }
            } catch {
                let message: String = "Unable to create realm instance \(error)"
                assertionFailure(message)
                preconditionFailure(message)
            }
        } else {
            do {
                try realm.write() {
                    let newDB = WeatherDB(json: json)
                    self.realm.add(newDB)
                }
            } catch {
                let message: String = "Unable to create realm instance \(error)"
                assertionFailure(message)
                preconditionFailure(message)
            }
        }
        realmModel = realm.objects(WeatherDB.self)
    }
}
