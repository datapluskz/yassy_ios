//
//  RateTableViewCell.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 31.05.2021.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тариф"
        label.textColor = .yassyLight
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.text = "Стандарт"
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 18)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "\(DetailItems.price) ₸"
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 18)
        return label
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
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        backgroundColor = .white
    }
    
    private func setupLayouts() {
        [titleLabel, gradeLabel, priceLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        gradeLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        priceLabel.anchor(top: gradeLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
    }
}
