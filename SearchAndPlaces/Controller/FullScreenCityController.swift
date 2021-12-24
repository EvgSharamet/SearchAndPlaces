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

    //MARK: - types
    
    typealias RequestResult = Result<WeatherService.WeatherData, Swift.Error>
    
    //MARK: - data
    
    var cityName: String?
    
    private var mapView: MKMapView?
    private var fullScreenStackView: UIStackView?
    private var mainView: fullScreenView?
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - private functions

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
            case .failure(_):
                let alert = UIAlertController(title: "Warning", message: "This city wasn't found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        WeatherService.shared.requestWeatherOf(place: cityName) { result in
            switch result {
                case .success(let weatherData):
                    self.mainView?.createWeatherCells(data:weatherData)
                case .failure(_):
                let alert = UIAlertController(title: "Warning", message: "Weather data didn't load", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

private extension MKMapView {
    
    //MARK: - internal functions
    
    func centerToLocation(_ location: GeocodeService.Coordinate2D, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude ),
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
}

