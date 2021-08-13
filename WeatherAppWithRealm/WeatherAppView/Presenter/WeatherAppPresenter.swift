//
//  WeatherAppPresenter.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation

protocol WeatherAppViewControllerProtocol {
    func updateLable(text: String?)
}

final class WeatherAppPresenter {

    weak var view: WeatherAppViewController?

    var delegate: WeatherAppViewControllerProtocol?
    
    required init(view: WeatherAppViewController?) {
        self.view = view
    }
    
    func featchData() {
        
        NetworkLayer().fetchAllWeathers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let welcome):
                if let weatherArray = welcome.weather {
                    for weather in weatherArray {
                        RealmDataBase().saveCodablaModelToDatabase(json: weather)
                    }
                }
            case .failure(let error):
                print("Error`; \(error.localizedDescription)")
            }
            
            self.getFromDataBase()
        }
        print("🛑")
    }
    
    func getFromDataBase() {
        RealmDataBase().getObject { weatherMain in
            self.delegate?.updateLable(text: weatherMain)
        }
    }
    
    func configureView() {
      let dataBase = RealmDataBase()
        dataBase.dataBaseIsEmpty ? featchData() : getFromDataBase()
    }
    
}
