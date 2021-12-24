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
    var gradient: CAGradientLayer?
    
    func prepare() {
        self.backgroundColor = .green
        self.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        gradient = CAGradientLayer {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.colors = [
                UIColor.black.withAlphaComponent(0.96).cgColor,
                UIColor.darkGray.withAlphaComponent(0.02).cgColor,
                UIColor.black.withAlphaComponent(0.96).cgColor
            ]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        }
        guard let gradient = self.gradient else {
            return
        }
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient?.frame = bounds
    }
}
