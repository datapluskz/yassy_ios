//
//  ShowAddressView.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 13.05.2021.
//

import UIKit

class ShowAddressView: UIView {
    
    // MARK: - Properties
    var sizeScreen = UIScreen.main.bounds.height
    var locationIcon = UIImageView(image: #imageLiteral(resourceName: "point").withRenderingMode(.alwaysOriginal))
    
    lazy var addressLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.textAlignment = .natural
        lb.numberOfLines = 0
        lb.text = "test"
        return lb
    }()
    
    lazy var addressButton: UIButton = {
        let button = UIButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("Готова", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .yassyOrange
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var addressStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            locationIcon,
            addressLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        [locationIcon, addressLabel, addressButton].forEach {
            addSubview($0)
        }
        locationIcon.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 8, bottom: 0, right: 0))
        addressLabel.anchor(top: topAnchor, leading: locationIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 8, bottom: 0, right: 0))
        addressButton.anchor(top: addressLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        configureView()
    }
    
    private func configureView() {
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: sizeScreen / 5.5).isActive = true
        
        /// configure image
        locationIcon.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
