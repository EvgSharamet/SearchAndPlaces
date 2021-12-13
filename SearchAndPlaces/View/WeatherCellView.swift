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
    
    var iconImageView: UIImageView?
    var destributionTimeStackView: UIStackView?
    var temperatureLabel: UILabel?
    

    private var timeLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    func prepare(inputData: WeatherService.WeatherInfo) {
        
        self.layer.cornerRadius = 30
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let temperatureLabel = UILabel()
        self.addSubview(temperatureLabel)
        self.temperatureLabel = temperatureLabel
        temperatureLabel.text = String(inputData.temp) + "°"
        temperatureLabel.textColor = .white
        temperatureLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(10)
            maker.rightMargin.equalToSuperview().inset(10)
            maker.height.equalTo(30)
        }
        
        let iconImageView = UIImageView()
        self.addSubview(iconImageView)
        self.iconImageView = iconImageView
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
        
        let urlForImage = URL(string: "https://openweathermap.org/img/wn/\(inputData.icon)@2x.png")
        let data = try? Data(contentsOf: urlForImage!)
        iconImageView.image = UIImage(data: data!)
        
        let destributionTimeStackView = UIStackView()
        self.destributionTimeStackView = destributionTimeStackView
        self.addSubview(destributionTimeStackView)
        destributionTimeStackView.axis = .vertical
        destributionTimeStackView.distribution = .fillEqually
        self.destributionTimeStackView?.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.height.equalTo(80)
            maker.width.equalToSuperview()
        }
        
        let descriptionLabel = UILabel()
        destributionTimeStackView.addArrangedSubview(descriptionLabel)
       
        descriptionLabel.text = inputData.description
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = descriptionLabel.font.withSize(16)
        let timeLabel = UILabel()
        destributionTimeStackView.addArrangedSubview(timeLabel)
        self.timeLabel = timeLabel
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        timeLabel.text = (dateFormatter.string(from: inputData.time)) + ":00"
        timeLabel.textColor = .white
        timeLabel.textAlignment = .center
    }
}

