//
//  CitiesService.swift
//  Weather Application
//
//  Created by Khadija Asim on 16/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

typealias CitiesResult = Result<[CityModel?]?, Error>
typealias CitiesFetchCompletion = (CitiesResult)->()

struct CitiesService: DataModelDecoder {

    func fetchCities(_ completion: @escaping CitiesFetchCompletion) {
        guard let path = Bundle.main.url(forResource: "city.list", withExtension: "json") else {return}
        let jsonData = try? Data(contentsOf: path)
        do {
            let cities : [CityModel?]? = try self.decodeModel(data: jsonData)
            guard let citiesResult = cities else {
                completion(.failure(NetworkError.failed))
                return
            }
            completion(.success(citiesResult))
        } catch {
            completion(.failure(NetworkError.unableToDecode))
        }
    }
    
}
