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
    lazy private var citiesService = CitiesService()
    var forecast: WeatherForecastResult? {
        didSet {
            print(forecast as Any)
        }
    }
    var cities: [CityModel?]? {
           didSet {
               print(cities as Any)
           }
       }

    override func viewDidLoad() {
        super.viewDidLoad()
       // fetchForecast()
        fetchCities()
    }

    func fetchForecast() {
        forecastService.fetchWeatherForecast("71549") { (result) in
            switch result {
                case.success(let forecast):
                    self.forecast = forecast
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

    func fetchCities() {
        citiesService.fetchCities() { (result) in
            switch result {
                case.success(let cities):
                    self.cities = cities
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }

}

