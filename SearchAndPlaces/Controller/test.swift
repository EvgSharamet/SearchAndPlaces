//
//  test.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 08.12.2021.
//

import Foundation
import UIKit
import SnapKit

class testController: UIViewController {

    typealias RequestResult = Result<WeatherService.WeatherData, Swift.Error>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView(data)
    }
    
    func setupView(data: RequestResult) {
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { maker in
            maker.height.equalTo(260)
            maker.width.equalToSuperview()
            maker.center.equalToSuperview()
        }
        
        scrollView.backgroundColor = .magenta

        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8.0).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8.0).isActive = true

        stackView.spacing = 20
        stackView.backgroundColor = .white
        
        
        
        /* let cellView = WeatherCellView()
        stackView.addArrangedSubview(cellView)
        let data = WeatherService.WeatherInfo(icon: "04n",description: "дождь", time:  "23.00", temperature: 48 )
        cellView.prepare(inputData: data)
        cellView.backgroundColor = .green
        */
    }
}
