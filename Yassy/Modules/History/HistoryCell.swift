//
//  HistoryCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import UIKit

class HistoryCell: BaseCollectionViewCell {
    override class func description() -> String {
        return "HistoryCell"
    }
    
    let dateLabel = UILabel()
    let declinedByLabel = UILabel()
    let seperatorView = UIView()
    let grayImageView = UIImageView(image: #imageLiteral(resourceName: "grayPoint"))
    let orangeImageView = UIImageView(image: #imageLiteral(resourceName: "orangePoint"))
    let aPointAddressLabel = UILabel()
    let bPointAddressLabel = UILabel()
    lazy var firstStackView = UIStackView(arrangedSubviews: [grayImageView, aPointAddressLabel])
    lazy var secondStackView = UIStackView(arrangedSubviews: [orangeImageView, bPointAddressLabel])
    
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        
        [dateLabel, declinedByLabel, seperatorView, firstStackView, secondStackView].forEach { (view) in
            contentView.addSubview(view)
        }
        
        dateLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        declinedByLabel.setAnchor(top: contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        seperatorView.setAnchor(top: dateLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 1)
        firstStackView.setAnchor(top: seperatorView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        secondStackView.setAnchor(top: firstStackView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
       
        
    }
    
    private func configureViews(){
        self.layer.cornerRadius = 16
        self.backgroundColor = .white
        self.setInsideCellShadow()
        
        declinedByLabel.font = .systemFont(ofSize: 14)
        declinedByLabel.textColor = UIColor.yassyOrange
        dateLabel.textAlignment = .left
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        
        dateLabel.font = .systemFont(ofSize: 14)
        
        [grayImageView, orangeImageView].forEach { (view) in
            view.contentMode = .scaleAspectFit
            view.heightAnchor.constraint(equalToConstant: 18).isActive = true
            view.widthAnchor.constraint(equalToConstant: 18).isActive = true
        }
        
        [aPointAddressLabel, bPointAddressLabel].forEach { (label) in
            label.font = .systemFont(ofSize: 16)
            label.textAlignment = .left
        }
        
        [firstStackView, secondStackView].forEach { (stack) in
            stack.axis = .horizontal
            stack.alignment = .leading
            stack.distribution = .fillProportionally
        }
        
    }
    
    func generateCell(_ model: HistoryModel){
        aPointAddressLabel.text = model.s_address
        bPointAddressLabel.text = model.d_address
        
        if model.cancelled_by == "USER" {
            declinedByLabel.text = "ВЫ ОТМЕНИЛИ"
        }
        
        if model.cancelled_by == "PROVIDER" {
            declinedByLabel.text = "ВОДИТЕЛЬ ОТМЕНИЛ"
        }
        
        if model.status == "COMPLETED" {
            declinedByLabel.text = "ЗАВЕРШЕН"
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru")
        dateFormatterPrint.dateFormat = "EEEE HH:mm"

        let finished = model.assigned_at
        let date: NSDate? = dateFormatterGet.date(from: finished ?? "") as NSDate?
        guard let dd = date else { return }
        let finalDate = dateFormatterPrint.string(from: dd as Date)
        
        dateLabel.text = finalDate
    }
}
