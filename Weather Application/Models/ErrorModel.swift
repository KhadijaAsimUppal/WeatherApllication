//
//  ErrorModel.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

struct ErrorModel: Decodable {
    let errors: [String?]?
    let fields: [String?]?
}
