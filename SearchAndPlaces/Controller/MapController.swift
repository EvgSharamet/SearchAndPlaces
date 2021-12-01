//
//  MapController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 14.11.2021.
//

import Foundation

import UIKit
import SnapKit
import MapKit
import CoreLocation

class MapController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.delegate = self
        
        mapView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        let initialLocation = CLLocation(latitude: 54.7064900, longitude: 20.5109500)
        mapView.centerToLocation(initialLocation)
    }
}

private extension MKMapView {
    
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    
      let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }

/*    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }*/
}

extension MapController: MKMapViewDelegate {
    
}
