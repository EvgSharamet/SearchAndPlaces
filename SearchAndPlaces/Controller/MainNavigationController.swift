//
//  MainNavigationController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 10.11.2021.
//

import Foundation
import UIKit
import SnapKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchScreen = SearchViewController()
        searchScreen.onItemSelectedDelegate = onItemSelected
        pushViewController(searchScreen, animated: true)
    }
    
    private func onItemSelected(cityName: String) {
        let fullImage = FullScreenCityController()
        fullImage.cityName = cityName
        pushViewController(fullImage, animated: true)
    //  let testWindow = testController()
     // pushViewController(testWindow, animated: false)
    }
}
