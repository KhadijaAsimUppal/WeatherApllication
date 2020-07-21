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

struct ImageService {
    var networkHandler: NetworkHandler

    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}
