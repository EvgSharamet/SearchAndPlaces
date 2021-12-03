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
    }
    
    func setupCellView() {
        
        let cellView = WeatherCellView()
        let data = WeatherService.WeatherInfo(icon: "04n",description: "снег", time:  "23.00", temperature: 2 )
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

}
