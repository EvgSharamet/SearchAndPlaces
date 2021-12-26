//
//  gradientView.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 24.12.2021.
//

import Foundation
import UIKit
import SnapKit

class GradientView: UIView {
    lazy var gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.colors = [
                UIColor.black.withAlphaComponent(0.96).cgColor,
                UIColor.darkGray.withAlphaComponent(0.02).cgColor,
                UIColor.black.withAlphaComponent(0.96).cgColor
            ]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    func prepare() {
        self.backgroundColor = UIColor(displayP3Red: 253, green: 245, blue: 230, alpha: 1)
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }
}
