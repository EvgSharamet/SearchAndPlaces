//
//  WeatherViewController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 15.11.2021.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

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

class WeatherViewController: UIViewController {
    
    enum Exception: Error {
        case ServerError
        case ParsingError
        case JsonParsingError
    }
    
    public var cityName: String?
    
    private var cityСoordinates: CLLocationCoordinate2D?
    private var weatherIconImageView: UIImageView?
    private var weatherDescriptionLabel: UILabel?
    private var weatherTemperatureLabel: UILabel?
    private var url: URL?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        setupCellView()
        coordinatesToJson()
    }
    
    func setupCellView() {
        
        let cellView = WeatherCellView()
        let data = WeatherCellView.СellData(icon: "04n",description: "снег", time:  "23.00", temperature: 2 )
        cellView.prepare(inputData: data)
        view.addSubview(cellView)
        
        cellView.snp.makeConstraints { maker in
            maker.height.equalTo(140)
            maker.width.equalTo(110)
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().inset(20)
        }
    }
    
    func setupView() {
        
        view.backgroundColor = .systemBackground
        
        let cityNameLabel = UILabel()
        cityNameLabel.text = cityName
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.backgroundColor = .lightGray
        view.addSubview(cityNameLabel)
        
        cityNameLabel.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            maker.height.equalTo(80)
            maker.width.equalTo(200)
        }
    }
    
    func coordinatesToJson() {
        
        guard let cityName = cityName else {
            return
        }
        
        getCoordinateFrom(address: cityName ) { (location, error) in
            self.cityСoordinates = location
            do{
                try self.jsonToResponse()
            } catch {
                print( "Error here")
            }
        }
    }
    
    func jsonToResponse() throws {
        
        guard let cityСoordinates = cityСoordinates else {
            return
        }
        let decoder = JSONDecoder()
        guard let url = URL( string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(cityСoordinates.latitude)&lon=\(cityСoordinates.longitude)&lang=ru&exclude=minutely,daily&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
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
        print(answer)
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
