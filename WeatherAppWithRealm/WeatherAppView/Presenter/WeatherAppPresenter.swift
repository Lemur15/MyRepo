//
//  WeatherAppPresenter.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 12.08.2021.
//

import Foundation

protocol WeatherAppPresenterProtocol {
    
   func configureView()
}

final class WeatherAppPresenter: WeatherAppPresenterProtocol {

    weak var view: WeatherAppViewController?
    
    required init(view: WeatherAppViewController?) {
        self.view = view
    }

    func configureView() {
        NetworkLayer.shared.fetchAllWeathers()
        
        let WeatherInRealmDataBase = RealmDataBase().realmWeatherModel.first
        
        guard let weatherMain = WeatherInRealmDataBase?.main else { return }
        view?.setAboutWeatherLabelText(with: weatherMain )
    }
    
}
