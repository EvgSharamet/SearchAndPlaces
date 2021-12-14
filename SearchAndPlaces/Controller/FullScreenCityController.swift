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

    public var cityName: String?
    private var mapView: MKMapView?
    private var fullScreenStackView: UIStackView?
    private var mainView: fullScreenView?
    
    typealias RequestResult = Result<WeatherService.WeatherData, Swift.Error>
    var weatherTodayStackView: UIStackView?
    var weatherTomorrowStackView: UIStackView?
    
    @frozen public enum Result<Success, Failure> where Failure : Error {
        case success(Success)
        case failure(Failure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //setupMap()
        setupView()
    }
    
    func setupView() {
        
        let mainView = fullScreenView()
        self.mainView = mainView
        view.addSubview(mainView)
        mainView.prepare()
        
        guard let cityName = cityName else {
            return
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
    
    func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000) {
        
        let coordinateRegion = MKCoordinateRegion(
        center: location,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
}

extension FullScreenCityController: MKMapViewDelegate {
    
}
