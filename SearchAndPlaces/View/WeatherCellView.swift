//
//  WeatherCellView.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 01.12.2021.
//

import Foundation
import UIKit
import SnapKit

class WeatherCellView: UIView {
    
    struct cellData {
        
        var icon: Data //Перепроверь что точно дата
        var description: String
        var time: String
        var temperature: Float
    }
    
    private var iconImageView: UIImageView?
    private var descriptionLabel: UILabel?
    private var timeLabel: UILabel?
    private var temperatureLabel: UILabel?
    
    func prepare() {
        
        self.backgroundColor = .lightGray
        
    }
}
