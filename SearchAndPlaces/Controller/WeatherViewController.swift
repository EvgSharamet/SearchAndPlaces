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
        
    struct coord: Codable {
        
        let lat: Double
        let lon: Double
    }
    
    struct hourly: Codable {
        
        let temp: Float
        let icon: String
        let weather: Weather
    }
    
    let lat: Double
    let lon: Double
    let hourly: [hourly]
}

class WeatherViewController: UIViewController {
    
    enum Exception: Error {
        
        case ServerError
        case ParsingError
    }
    
    public var cityName: String?
    
    private var cityСoordinates: CLLocationCoordinate2D? {
        didSet {
            print("cityСoordinates didSet: \(cityСoordinates)")
        }
    }
    
    private var weatherIconImageView: UIImageView?
    private var weatherDescriptionLabel: UILabel?
    private var weatherTemperatureLabel: UILabel?
    private var url: URL?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        
        do {
            
            try printWeather() } catch {
            print("Error")
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
        
        weatherIconImageView = UIImageView()
        guard let weatherImageView = weatherIconImageView else { return }
    
        self.view.addSubview(weatherImageView)
        
        weatherImageView.snp.makeConstraints { maker in
            
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(100)
            maker.width.equalTo(100)
        }
        
        weatherDescriptionLabel = UILabel()
        guard let weatherDescriptionLabel = weatherDescriptionLabel else { return }
    
        weatherDescriptionLabel.textColor = .black
        weatherDescriptionLabel.textAlignment = .center
        view.addSubview(weatherDescriptionLabel)
        
        weatherDescriptionLabel.snp.makeConstraints { maker in
            
            maker.centerX.equalToSuperview()
            maker.top.equalTo(weatherImageView.snp.bottom).inset(20)
            maker.height.equalTo(40)
            maker.width.equalTo(300)
        }
        
        weatherTemperatureLabel = UILabel()
        guard let weatherTemperatureLabel = weatherTemperatureLabel else { return }
        
        weatherTemperatureLabel.textColor = .black
        weatherTemperatureLabel.textAlignment = .center
        view.addSubview(weatherTemperatureLabel)
        weatherTemperatureLabel.backgroundColor = .darkGray
        
        weatherTemperatureLabel.snp.makeConstraints { maker in
            
            maker.centerX.equalToSuperview()
            maker.top.equalTo(weatherDescriptionLabel).inset(60)
            maker.height.equalTo(40)
            maker.width.equalTo(40)
        }
    }
    
    func printWeather()  throws {
        
        guard let cityName = cityName else {
            return
        }
        
        getCoordinateFrom(address: cityName ) { (location, error) in
            self.cityСoordinates = location
            do{
                try self.createUrl()
            } catch {
                print( " Error here")
            }
        }
    }
    
    func createUrl() throws {
        
        guard let location = cityСoordinates else { return }
        
        guard let url = URL( string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.latitude)&lon=\(location.longitude)&lang=ru&exclude=minutely,daily&units=metric&appid=167ec7c4487c8b004df1c9b138fb6600")
        else {
        
            print ( "Error in URL" )
            return
        }
        
        print (url)
        
        var jsonString: String = ""
        
        do {
            jsonString =  try String(contentsOf: url, encoding:.utf8)
        }   catch {
            
            print (error.localizedDescription)
        }
            print ( jsonString )
    
            let decoder = JSONDecoder()
   
            let jsonData = Data(jsonString.utf8)
        
        do {
        
            let answer = try decoder.decode(Response.self, from: jsonData)
            print ( answer )
        
          //  weatherDescriptionLabel?.text = answer.weather[0].description
            //weatherTemperatureLabel?.text = String (Int (answer.main.temp - 273.15 ) )
            //print( answer.main.temp )
        
       //     let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(answer.weather[0].icon)@2x.png")
       //     let data = try? Data(contentsOf: urlForImage!)
      //      weatherIconImageView?.image = UIImage(data: data!)
        } catch {
        
            print(error.localizedDescription)
        }
        
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
