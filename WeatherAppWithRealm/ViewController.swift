//
//  ViewController.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 11.08.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet private weak var table: UITableView!
    
    @IBOutlet private weak var getDataButton: UIButton!
    
    @IBOutlet private weak var anyLabel: UILabel!
    
    private var models = [Weather]()
    
    let realm = try! Realm()
    lazy var testModels: Results<WeatherRealm> = { self.realm.objects(WeatherRealm.self)}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getDataButtonTapped(_ sender: Any) {
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?id=8261417&appid=b636992ae3b73b91aef4efedf2b2ad42").responseJSON { response in
            if response.result.isSuccess {
                let data = JSON(response.value)
                
                let weatherJson = data["weather"].arrayValue
                
                for weather in weatherJson {
                 let currentWeather = Weather(json: weather)
                    print(currentWeather)
                    self.models.append(currentWeather)
                }
            } else {
                print(response.result.error.debugDescription)
            }
        }
        defaultWeatherModels()
        anyLabel.text = testModels.first?.main
    }
    
    private func defaultWeatherModels() {
        
        if testModels.count == 0 {
            try! realm.write() {
                let defaultWeathers = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids"]
                
                for weather in defaultWeathers {
                    let newWeather = WeatherRealm()
                    newWeather.main = weather
                    self.realm.add(newWeather)
                }
            }
        }
        testModels = realm.objects(WeatherRealm.self)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
