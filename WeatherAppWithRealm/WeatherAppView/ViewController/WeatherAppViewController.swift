//
//  ViewController.swift
//  WeatherAppWithRealm
//
//  Created by Dev on 11.08.2021.
//

import UIKit

final class WeatherAppViewController: UIViewController, WeatherAppViewControllerProtocol {
    func updateLable(text: String?) {
        self.anyLabel.text = text
    }
    
    private var presenter: WeatherAppPresenter!
    
    @IBOutlet private weak var anyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WeatherAppPresenter(view: self)
        presenter.delegate = self
        
        self.presenter.configureView()
    }
    
    func setAboutWeatherLabelText(with text: String) {
    
        anyLabel.text = text
    }
}

