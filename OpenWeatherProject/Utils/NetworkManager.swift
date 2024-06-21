//
//  NetworkManager.swift
//  OpenWeatherProject
//
//  Created by 권대윤 on 6/21/24.
//

import Foundation

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchWeatherData(lat: Double, lon: Double, completion: @escaping (WeatherData) -> Void) {
        let url = APIURL.url(lat: lat, lon: lon)
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(response.response?.statusCode ?? 0)
                print(error)
            }
        }
    }
    
}
