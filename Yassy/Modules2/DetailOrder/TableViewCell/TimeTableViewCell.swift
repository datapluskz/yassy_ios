//
//  TimeTableViewCell.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 31.05.2021.
//

import UIKit

class TimeTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.textColor = .yassyLight
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.regular, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня 12:34"
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
        heightAnchor.constraint(equalToConstant: 90).isActive = true
        backgroundColor = .white
    }
    
    private func setupLayouts() {
        [titleLabel,timeLabel].forEach {
            addSubview($0)
        }
        
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        timeLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
    }
}
