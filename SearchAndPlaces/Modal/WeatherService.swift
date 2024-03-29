//
//  WeatherService.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 03.12.2021.
//

import Foundation
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
            let dt: Int
            let temp: Float
            let weather: [Weather]
        }

        let lat: Double
        let lon: Double
        let hourly: [Hourly]
    }
    
    struct WeatherInfo {
        var icon: String
        var description: String
        var time: Date
        var temp: Int
    }
    
    struct WeatherData {
        let coord: Response.Coord
        let today: [WeatherInfo]
        let tomorrow: [WeatherInfo]
    }
    
    
    typealias RequestResult = Result<WeatherData, Swift.Error>
    typealias RequestResultHandler = (RequestResult) -> Void
    
    //MARK: - data
    
    static let shared = WeatherService()
    
    //MARK: - internal functions
    
    func requestWeatherOf(place: String, handler: @escaping RequestResultHandler) {

        CLGeocoder().geocodeAddressString(place) { placemark, error in
            guard let location = placemark?.first?.location?.coordinate else {
                let err = error ?? Error(info: "no location \(place)")
                handler(.failure(err))
                return
            }
            do {
                let weatherData = try self.jsonToResponse(location)
                handler(.success(weatherData))
            } catch {
                handler(.failure(error))
            }
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
        
        let rawDataToday = answer.hourly.dropLast(23)
        let rawDataTomorrow = answer.hourly.dropFirst(24)
        var weatherInfoToday:  [WeatherInfo] = []
        var weatherInfoTomorrow: [WeatherInfo] = []

        for item in rawDataToday {
            weatherInfoToday.append(WeatherInfo(icon: item.weather.first?.icon ?? "01n", description: item.weather.first?.description ?? "missing", time: NSDate(timeIntervalSince1970: TimeInterval(item.dt)) as Date, temp: Int(item.temp)))
        }
        
        for item in rawDataTomorrow {
            weatherInfoTomorrow.append(WeatherInfo(icon: item.weather.first?.icon ?? "01n", description: item.weather.first?.description ?? "missing", time: NSDate(timeIntervalSince1970: TimeInterval(item.dt)) as Date, temp: Int(item.temp)))
        }
        
        return WeatherData(coord: WeatherService.Response.Coord(lat: answer.lat,lon: answer.lon), today: weatherInfoToday, tomorrow: weatherInfoTomorrow )
    }
}
