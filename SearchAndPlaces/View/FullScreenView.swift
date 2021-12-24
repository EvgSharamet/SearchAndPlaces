//
//  fullScreenView.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 12.12.2021.
//

import Foundation
import SnapKit
import UIKit
import MapKit

class fullScreenView: UIView {
    
    //MARK: - data
    
    var mapView: MKMapView?
    var cityNameLabel: UILabel?
 
    private var weatherTodayStackView: UIStackView?
    private var weatherTomorrowStackView: UIStackView?
    private var fullScreenStackView: UIStackView?

    //MARK: - internal functions
    
    func prepare() {
        setupView()
        setupMap()
        setupMainStackView()
    }

    func createWeatherCells(data: WeatherService.WeatherData) {
        guard let weatherTodayStackView = weatherTodayStackView else {
            return
        }
        guard let weatherTomorrowStackView = weatherTomorrowStackView else {
            return
        }
        
        for item in data.today {
            let cell = WeatherCellView()
            cell.prepare(inputData: item)
            weatherTodayStackView.addArrangedSubview(cell)
            cell.snp.makeConstraints { maker in
                maker.height.equalTo(160)
                maker.width.equalTo(120)
            }
        }

        for item in data.tomorrow {
            let cell = WeatherCellView()
            cell.prepare(inputData: item)
            weatherTomorrowStackView.addArrangedSubview(cell)
            cell.snp.makeConstraints { maker in
                maker.height.equalTo(160)
                maker.width.equalTo(120)
            }
        }
    }
    
    //MARK: - private functions
    
    private func  setupView() {
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.backgroundColor = .lightGray
        let gradient = GradientView()
        self.addSubview(gradient)
        gradient.prepare()
        print(gradient.frame)
    }
    
    private func setupMap() {
        let mapView = MKMapView()
        self.mapView = mapView
        self.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(-20)
            make.height.equalTo(200)
            make.width.equalToSuperview()
        }
    }
    
    private func setupMainStackView() {
        guard let mapView = self.mapView else {
            return
        }
        
        let fullScreenStackView = UIStackView()
        fullScreenStackView.axis = .vertical
        fullScreenStackView.spacing = 15
        self.addSubview(fullScreenStackView)
        fullScreenStackView.alignment = .leading
        fullScreenStackView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp_bottomMargin)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview()
        }

        let cityNameLabel = UILabel()
        self.cityNameLabel = cityNameLabel
        fullScreenStackView.addArrangedSubview(cityNameLabel)
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 45)
        cityNameLabel.textColor = .white

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let todayDateLabel = UILabel()
        fullScreenStackView.addArrangedSubview(todayDateLabel)
        todayDateLabel.text = "Сегодня," + (dateFormatter.string(from: Date()))
        todayDateLabel.textColor = .white
        todayDateLabel.textAlignment = .center

        let scrollViewToday = UIScrollView()
        fullScreenStackView.addArrangedSubview(scrollViewToday)
        scrollViewToday.snp.makeConstraints { maker in
            maker.height.equalTo(160)
            maker.width.equalToSuperview()
        }

        let weatherTodayStackView = UIStackView()
        self.weatherTodayStackView = weatherTodayStackView
        scrollViewToday.addSubview(weatherTodayStackView)
        weatherTodayStackView.spacing = 15
        weatherTodayStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
            
        let tomorrowDateLabel = UILabel()
        fullScreenStackView.addArrangedSubview(tomorrowDateLabel)
        tomorrowDateLabel.text = "Завтра," + dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        tomorrowDateLabel.textColor = .white
        tomorrowDateLabel.textAlignment = .center

        let scrollViewTomorrow = UIScrollView()
        fullScreenStackView.addArrangedSubview(scrollViewTomorrow)
        scrollViewTomorrow.snp.makeConstraints { maker in
            maker.height.equalTo(160)
            maker.width.equalToSuperview()
        }

        let weatherTomorrowStackView = UIStackView()
        self.weatherTomorrowStackView = weatherTomorrowStackView
        scrollViewTomorrow.addSubview(weatherTomorrowStackView)
        weatherTomorrowStackView.spacing = 15
        weatherTomorrowStackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
