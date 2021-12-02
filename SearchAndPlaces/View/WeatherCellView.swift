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
    
    struct СellData {
        
        var icon: Data //Перепроверь что точно дата
        var description: String
        var time: String
        var temperature: Float
    }
    
    var data: СellData?
    
    var iconImageView: UIImageView?
    var destributionTimeStackView: UIStackView?
    var temperatureLabel: UILabel?

    private var timeLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    func prepare() {
        
        self.layer.cornerRadius = 30
        self.backgroundColor = .darkGray
     
        let temperatureLabel = UILabel()
        self.addSubview(temperatureLabel)
        self.temperatureLabel = temperatureLabel
        temperatureLabel.text = "8°"
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
        
        let urlForImage = URL(string: "https://openweathermap.org/img/wn/04d@2x.png")
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
            maker.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        
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

