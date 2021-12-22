//
//  FullScreenAboutCityController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 12.11.2021.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation
import MapKit

class FullScreenCityController: UIViewController {

    @frozen public enum Result<Success, Failure> where Failure : Error {
        case success(Success)
        case failure(Failure)
    }
    typealias RequestResult = Result<WeatherService.WeatherData, Swift.Error>
    
    public var cityName: String?
    private var mapView: MKMapView?
    private var fullScreenStackView: UIStackView?
    private var mainView: fullScreenView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let mainView = fullScreenView()
        self.mainView = mainView
        view.addSubview(mainView)
        mainView.prepare()
        
        guard let cityName = cityName else {
            return
        }
        mainView.cityNameLabel?.text = cityName
        
        GeocodeService.shared.getCoordinate(cityName: cityName) { result in
            switch result {
                case .success(let location):
                    mainView.mapView?.centerToLocation(location)
            case .failure(let error):
                print(error)
            }
        }
     
        WeatherService.shared.requestWeatherOf(place: cityName) { result in
            switch result {
                case .success(let weatherData):
                    self.mainView?.createWeatherCells(data:weatherData)
                case .failure(let error):
                    print(error)
            }
        }
    }
}

private extension MKMapView {
    
    func centerToLocation(_ location: GeocodeService.Coordinate2D, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude ),
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
}

