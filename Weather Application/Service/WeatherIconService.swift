//
//  imageService.swift
//  Weather Application
//
//  Created by Khadija Asim on 21/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation
import UIKit

typealias IconRequestResult = Result<UIImage, Error>
typealias IconRequestCompletion = (IconRequestResult)->()

struct WeatherIconService {
    var networkHandler: NetworkHandler

    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension WeatherIconService {

    func fetchIcon(for path: String, completion: @escaping IconRequestCompletion) {
        let endPoint = WeatherAPI.getIcon(iconPath: path)
        networkHandler.fetchData(endPoint) {(result) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                do {
                    guard let image = UIImage(data: data) else {completion(.failure(NetworkError.failed))
                        return}
                    completion(.success(image))
                } 
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
