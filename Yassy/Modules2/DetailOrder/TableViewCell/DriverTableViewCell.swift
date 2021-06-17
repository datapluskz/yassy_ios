//
//  DriverTableViewCell.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 31.05.2021.
//

import UIKit

class DriverTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Водитель"
        label.textColor = .yassyLight
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let driverName: UILabel = {
        let label = UILabel()
        label.text = DetailItems.driverName
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 18)
        return label
    }()
    
    let carName: UILabel = {
        let label = UILabel()
        label.text = DetailItems.car
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 18)
        return label
    }()
    
    let phoneNumber: UILabel = {
        let label = UILabel()
        label.text = "+7 \(DetailItems.phoneNumber)"
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 18)
        return label
    }()
    
    lazy var informationDriverStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            driverName,
            carName,
            phoneNumber
        ])
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureCell()
        setupLayouts()
    }
    
    private func configureCell() {
        heightAnchor.constraint(equalToConstant: 180).isActive = true
        backgroundColor = .white
    }
    
    private func setupLayouts() {
        [titleLabel, informationDriverStack].forEach {
            addSubview($0)
        }
        
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        informationDriverStack.anchor(top: titleLabel.safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
    }
}
