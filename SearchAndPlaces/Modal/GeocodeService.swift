//
//  mapService.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 13.12.2021.
//

import Foundation
import MapKit

class GeocodeService {
    //MARK: - types
    
    struct Error: Swift.Error {
        let info: String
    }

    struct Coordinate2D {
        let latitude: Double
        let longitude: Double
    }
    typealias RequestResult = Result<Coordinate2D, Swift.Error>
    typealias RequestResultHandler = (RequestResult) -> Void
    
    //MARK: - data

    static let shared = GeocodeService()
  
    //MARK: - internal functions
    
    func getCoordinate(cityName: String, handler: @escaping RequestResultHandler)  {
        CLGeocoder().geocodeAddressString(cityName) { placemark, error in
            guard let location = placemark?.first?.location else {
                let err = error ?? Error(info: "No location \(cityName)")
                handler(.failure(err))
                return
            }
            let result = Coordinate2D(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
            handler(.success(result))
        }
    }
}