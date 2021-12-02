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
    
    var data: cellData?
    
    var iconImageView: UIImageView?
    var destributionTimeStackView: UIStackView?
    var temperatureLabel: UILabel?

    private var timeLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    func prepare() {
        
        self.backgroundColor = .darkGray
     
        let temperatureLabel = UILabel()
        self.addSubview(temperatureLabel)
        self.temperatureLabel = temperatureLabel
        temperatureLabel.text = "8°"
        temperatureLabel.textColor = .white
        
        let iconImageView = UIImageView()
        self.addSubview(iconImageView)
        self.iconImageView = iconImageView
        iconImageView.contentMode = .scaleAspectFit
        
        let urlForImage = URL(string: "https://openweathermap.org/img/wn/04d@2x.png")
        let data = try? Data(contentsOf: urlForImage!)
        iconImageView.image = UIImage(data: data!)
        
        let destributionTimeStackView = UIStackView()
        self.destributionTimeStackView = destributionTimeStackView
        self.addSubview(destributionTimeStackView)
        destributionTimeStackView.axis = .vertical
        destributionTimeStackView.distribution = .fillEqually
        
        let descriptionLabel = UILabel()
        destributionTimeStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.text = "Description"
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        
        let timeLabel = UILabel()
        destributionTimeStackView.addArrangedSubview(timeLabel)
        self.timeLabel = timeLabel
        timeLabel.text = "XX.XX"
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
    }
}

