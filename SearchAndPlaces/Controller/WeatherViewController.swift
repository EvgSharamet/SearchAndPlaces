//
//  WeatherViewController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 15.11.2021.
//

import Foundation
import UIKit
import SnapKit

struct weatherData: Codable {
    var weather: [String]
}


class WeatherViewController: UIViewController {
    
    enum Exception: Error {
        case ServerError
        case ParsingError
    }
    
    public var cityName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try printWeather() } catch {
            print("ye")
        }
    }
    
    func printWeather()  throws {
        guard let cityName = cityName?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=167ec7c4487c8b004df1c9b138fb6600")
        else {
            print("ERROR")
            return
        }
  
       let jsonString =  try String(contentsOf: url, encoding:.utf8)

        let decoder = JSONDecoder()
        let jsonData = Data(jsonString.utf8)
        do {
            let people = try decoder.decode([weatherData].self, from: jsonData)
            print(people)
        } catch {
            print(error.localizedDescription)
        }
    }
}
