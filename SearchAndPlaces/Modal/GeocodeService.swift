//
//  mapService.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 13.12.2021.
//

import Foundation
import MapKit

class GeocodeService {
    struct Error: Swift.Error {
        let info: String
    }
    
    struct Coordinate2D {
        let latitude: Float
        let longitude: Float
    }
    static let shared = GeocodeService()
    typealias RequestResult = Result<Coordinate2D, Swift.Error>
    typealias RequestResultHandler = (RequestResult) -> Void
    
    func getCoordinate(cityName: String, handler: @escaping RequestResultHandler)  {
        
        CLGeocoder().geocodeAddressString(cityName) { placemark, error in
            guard let location = placemark?.first?.location else {
                let err = error ?? Error(info: "No location \(cityName)")
                handler(.failure(err))
                return
            }
            let result = Coordinate2D(latitude: Float(location.coordinate.latitude), longitude: Float(location.coordinate.longitude))
            handler(.success(result))
        }
    }
}
