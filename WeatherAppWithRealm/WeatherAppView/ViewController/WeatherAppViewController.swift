//
//  ViewController.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 11.08.2021.
//

import UIKit

protocol WeatherDescriptionViewControllerProtocol {
    
    func setAboutWeatherLabelText(with text: String)
}

final class WeatherAppViewController: UIViewController, WeatherDescriptionViewControllerProtocol {
    
    private var presenter: WeatherAppPresenter!
    
    @IBOutlet private weak var anyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WeatherAppPresenter(view: self)
        presenter.configureView()
    }
    
    func setAboutWeatherLabelText(with text: String) {
        
        anyLabel.text = text
    }
}

