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
        coordinatesToJson(place: place)
    }
    
    func coordinatesToJson(place: String) {
        getCoordinateFrom(address: place ) { (location, error) in
            guard let location = location else {
                return
            }

            do{
                try self.jsonToResponse(location)
            } catch {
                print( "Error here")
            }
        }
    }
    
    func jsonToResponse(_ location:CLLocationCoordinate2D ) throws {
        
        let decoder = JSONDecoder()
        guard let url = URL( string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&exclude=minutely,daily&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
        else {
            return
        }

        guard let jsonString = try? String(contentsOf: url, encoding:.utf8) else {
            return
        }
    
        let jsonData = Data(jsonString.utf8)
        guard let answer = try? decoder.decode(Response.self, from: jsonData) else {
            return
        }
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Swift.Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    //MARK: - private functions
    
    private init() {}
}

