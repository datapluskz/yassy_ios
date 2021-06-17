//
//  SearchOnMapButton.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import UIKit

class SearchOnMapButton: UIButton {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.setTitle("Указать на карте", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14)
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(.black, for: .normal)
        self.buttonCenterImagee(image: UIImage(named: "ic_pin-2")!, renderMode: .alwaysOriginal)
        self.buttonTitlePadding(top: 0, left: 14, bottom: 0, right: 0)
        self.setCellShadowTwo()
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
