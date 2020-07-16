//
//  ViewController.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy private var forecastService = WeatherForecastService(NetworkHandler())
    var forecast: WeatherForecastResult? {
        didSet {
            print(forecast as Any)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchForecast()
    }

    func fetchForecast() {

        forecastService.fetchWeatherForecast(cityId: "71549") { (result) in
            switch result {
                case.success(let forecast):
                    self.forecast = forecast
                case .failure(let error):
                    debugPrint(error)
            }

        }

    }



}

