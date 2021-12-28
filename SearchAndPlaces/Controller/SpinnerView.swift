//
//  SpinnerView.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 28.12.2021.
//

import Foundation
import UIKit
import SnapKit

class SpinnerView: UIView {
    
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    func setupView() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.2)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        self.addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
