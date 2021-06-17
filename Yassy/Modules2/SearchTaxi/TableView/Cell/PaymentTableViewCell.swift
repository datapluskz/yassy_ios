//
//  PaymentTableViewCell.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 04.05.2021.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .black
        // Configure the view for the selected state
    }

}
