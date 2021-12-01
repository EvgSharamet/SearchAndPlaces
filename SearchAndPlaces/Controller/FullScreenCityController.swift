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

class FullScreenCityController: UIViewController{
    
    public var cityName: String?
    private var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMap()
    }
        
    func setupMap() {
        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.delegate = self
        
        mapView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        guard let cityName = cityName else { return }
        
        getCoordinateFrom(address: cityName) { (locat, err) in
            print (locat ?? "rtlr")
            guard let locat = locat else { return }
        mapView.centerToLocation(locat)
        }
    }
    

    func setupView() {
        
        let fullScreenStackView = UIStackView()
        let cityNameLabel = UILabel()
        fullScreenStackView.axis = .vertical
        fullScreenStackView.backgroundColor = .blue
        self.view.addSubview(fullScreenStackView)
        fullScreenStackView.addSubview(cityNameLabel)
        
        fullScreenStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        cityNameLabel.backgroundColor = .white
        
        guard let cityName = cityName else { return }
        cityNameLabel.text = cityName
        print(getCoordinateFrom(address: cityName, completion: { (coord, error) in
            print(coord ?? "rtr")
        }))
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
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
