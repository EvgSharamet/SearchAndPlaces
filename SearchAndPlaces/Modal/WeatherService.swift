//
//  WeatherService.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 03.12.2021.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

class WeatherService {
    //MARK: - types
    
    struct Error: Swift.Error {
        let info: String
    }
    
    struct Response: Codable {
        
        struct Weather: Codable {
            let id: Int
            let main: String
            let description: String
            let icon: String
        }
            
        struct Coord: Codable {
            let lat: Double
            let lon: Double
        }
        
        struct Hourly: Codable {
            let temp: Float
            let icon: String
            let weather: Weather
        }
        
        let lat: Double
        let lon: Double
        let hourly: [Hourly]
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
    
    typealias RequestResult = Result<WeatherData, Swift.Error>
    typealias RequestResultHandler = (RequestResult) -> Void
    
    //MARK: - data
    
    static let shared = WeatherService()
    
    //MARK: - public functions
    
    func requestWeatherOf(place: String, handler: @escaping RequestResultHandler) {
        getCoordinateFrom(address: place ) { (location, error) in
            guard let location = location else {
                handler(.failure(Error(info: "no location")))
                return
            }
            do {
                let weatherData = try self.jsonToResponse(location)
                handler(.success(weatherData))
            } catch {
                handler(.failure(error as! WeatherService.Error))
            }
            print(WeatherData.self)
        }
    }
    
    //MARK: - private functions
    
    private func jsonToResponse(_ location:CLLocationCoordinate2D ) throws -> WeatherData {
        
        let decoder = JSONDecoder()
        guard let url = URL( string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&exclude=minutely,daily&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
        else {
            throw Error(info: "can't get url")
        }

        guard let jsonString = try? String(contentsOf: url, encoding:.utf8) else {
            throw Error(info: "can't decode url")
        }
    
        let jsonData = Data(jsonString.utf8)
        
        guard let answer = try? decoder.decode(Response.self, from: jsonData) else {
            throw Error(info: "can't decode Response")
        }
        print("ANSWER ->\(answer)<-ANSWER_END")
        
        let info = WeatherInfo(icon: answer.hourly.first?.icon ?? "", description: "", time: "", temperature: Int(answer.hourly.first?.temp ?? 30))
        
        print("INFO ->\(answer)<-INFOEND")
        return WeatherData(now: info , byHours: [:])
    }
    
   private func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Swift.Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    private init() {}
}

