//
//  WeatherViewController.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 15.11.2021.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

class WeatherViewController: UIViewController, UIScrollViewDelegate {
    
    public var cityName: String?
    
    private var cityСoordinates: CLLocationCoordinate2D?
    private var weatherIconImageView: UIImageView?
    private var weatherDescriptionLabel: UILabel?
    private var weatherTemperatureLabel: UILabel?
    private var scrollView: UIScrollView?
    private var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCellView()
    }

    func setupCellView() {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        view.addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.height.equalTo(200)
            maker.width.equalToSuperview()
            maker.center.equalToSuperview()
        }
        
        let cellView = WeatherCellView()
        let data = WeatherService.WeatherInfo(icon: "04n",description: "снег", time:  "23.00", temperature: 2 )
        cellView.prepare(inputData: data)
        
        let cellView2 = WeatherCellView()
        let data2 = WeatherService.WeatherInfo(icon: "04n",description: "дождь", time:  "23.00", temperature: 48 )
        cellView.prepare(inputData: data2)
        
        stackView.backgroundColor = .blue
        stackView.addArrangedSubview(cellView)
        stackView.addArrangedSubview(cellView2)
    }
    
    func setupView() {
        
        view.backgroundColor = .systemBackground
        
        let cityNameLabel = UILabel()
        cityNameLabel.text = cityName
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.backgroundColor = .lightGray
        view.addSubview(cityNameLabel)
        
        cityNameLabel.snp.makeConstraints{ maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            maker.height.equalTo(80)
            maker.width.equalTo(200)
        }
    }
}
