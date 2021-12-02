//
//  WeatherService.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 03.12.2021.
//

import Foundation
import UIKit
import SnapKit

class WeatherService {
    //MARK: - types
    
    struct Error: Swift.Error {
        let info: String
    }
    
    struct WeatherInfo {
        var icon: String
        var description: String
        var time: String
        var temperature: Int
    }
    
    struct WeatherData {
        let now: WeatherInfo
        let byHours: [Int: WeatherInfo]
    }
    
    typealias RequestResult = Result<WeatherData,Error>
    typealias RequestResultHandler = (RequestResult) -> Void
    
    //MARK: - data
    static let shared = WeatherService()
    
    //MARK: - public functions
    
    func requestWeatherOf(place: String, handler: RequestResultHandler) {
        
    }
    //MARK: - private functions
    
    private init() {}
}

