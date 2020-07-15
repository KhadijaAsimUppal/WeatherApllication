//
//  Router.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

/// Provides interface for network routing and defines an associated type *EndPoint* confirming to *EndPointType* protocol
protocol Router{

    associatedtype EndPoint: EndPointType

    @discardableResult
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) -> URLSessionTask?
}
