//
//  NetworkHandler.swift
//  Weather Application
//
//  Created by Khadija Asim on 15/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

/// For Setting network envoirenment of the app
enum NetworkEnvironment {
    case staging
    case production
    case development
}

/// Defines network and provides error strings for network request error
enum NetworkError: Error, DataModelDecoder {
    case authenticationError
    case badRequest
    case failed
    case noData
    case unableToDecode
    case noInternet
    case failedWithError(Data)

    var localizedDescription: String {
        switch self {
        case .authenticationError:
           return "Authentication Error"
        case .badRequest:
           return "Bad Request"
        case .failed:
           return "Network request Failed"
        case .failedWithError(let errorData):
            do {
                let errorModel : ErrorModel? = try self.decodeModel(data: errorData)
                return errorModel?.errors?.first as? String ?? "Something went wrong."
            } catch {
                let dict = try? JSONSerialization.jsonObject(with: errorData, options: []) as? [String : Any]
                debugPrint(dict ?? [])
                return "Decoding Error"
            }
        case .noData:
           return "No Data Found"
        case .unableToDecode:
           return "Decoding Error"
        case .noInternet:
           return "No Internet Connectivity."
        }
    }
}

enum NetworResponseStatus {
    case success
    case failure(NetworkError)
}

typealias NetworkRequestResult = Result<Data?, Error>
typealias NetworkServiceCompletion = (NetworkRequestResult)-> ()

/// Provides network request creation and routing
struct NetworkHandler {
    #if PROD
    static let environment: NetworkEnvironment = .production
    #else
    static let environment: NetworkEnvironment = .staging
    #endif
    private var router = NetworkRouter<WeatherAPI>()
}

extension NetworkHandler {

    /// Checks URLResponse statusCode and returns a *NetworkResponse* case depending upon status
    /// - Parameter urlResponse: URLResponse received back from URLTask
    private func parseHTTPResponse(_ urlResponse:HTTPURLResponse, data: Data?) -> NetworResponseStatus {
        switch urlResponse.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(.authenticationError)
        case 501...600:
            return  .failure(.badRequest)
        case 400:
            if let data = data {
                return .failure(.failedWithError(data))
            }
            fallthrough
        default:
            return .failure(.failed)
        }
    }

    /// Sends a  request for the reuested API endpoint and returns a completion closure with Data object or error string
    /// - Parameter endPoint: Must be a type confirming EndPointType protocol
    /// - Parameter completion: returns data or error string
    func fetchData<EndPoint>(_ endPoint: EndPoint, completion: @escaping NetworkServiceCompletion) where EndPoint:EndPointType{

        router.request(endPoint: endPoint as! WeatherAPI) {(data, response, error) in
            self.parseURLRequestData(data: data, response: response, error: error) { result in
                completion(result)
            }
        }
    }

    /// Parse the URLRequest response and returns a completion closure with Data object or error string
    /// - Parameter data: Data object received in URLRequest completion closure
    /// - Parameter response: URLResponse object received in URLRequest completion closure
    /// - Parameter error: Error object received in URLRequest completion closure
    /// - Parameter completion: completion closure with Data object or error string
    private func parseURLRequestData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping NetworkServiceCompletion) {

        if let _ = error {
            print(NetworkError.noInternet.localizedDescription)
            completion(.failure(NetworkError.noInternet))
            return
        }

        guard let httpURLResponse = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.failed))
            return
        }

        let networkResponse = parseHTTPResponse(httpURLResponse, data: data)
        switch networkResponse {
        case .success:
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        case .failure(let networkError):
            completion(.failure(networkError))
        }
    }
}

