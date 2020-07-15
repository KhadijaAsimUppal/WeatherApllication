//
//  EndPointType.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL         : URL { get }
    var path            : String { get }
    var httpMethod      : HTTPMethod { get }
    var task            : HTTPTask { get }
    var cachingPolicy   : URLRequest.CachePolicy { get }
}
