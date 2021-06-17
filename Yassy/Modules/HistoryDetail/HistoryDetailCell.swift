//
//  HistoryDetailCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 09.05.2021.
//

import UIKit

class HistoryDetailCell: BaseTableViewCell {
    override class func description() -> String {
        return "HistoryDetailCell"
    }
    
    let pointsContainerView = UIView()
    let dateLabel = UILabel()
    let declinedByLabel = UILabel()
    let firstSeperatorView = UIView()
    let grayImageView = UIImageView(image: #imageLiteral(resourceName: "grayPoint"))
    let orangeImageView = UIImageView(image: #imageLiteral(resourceName: "orangePoint"))
    let aPointAddressLabel = UILabel()
    let bPointAddressLabel = UILabel()
    lazy var aPointStackView = UIStackView(
        arrangedSubviews: [grayImageView, aPointAddressLabel])
    lazy var bPointStackView = UIStackView(
        arrangedSubviews: [orangeImageView, bPointAddressLabel])
    
    let tarifTitleLabel = UILabel()
    let tarifLabel = UILabel()
    let tarifSeperatorView = UIView()
    
    let priceLabel = UILabel()
    let priceSeperatorView = UIView()
    
    let paymentTitleLabel = UILabel()
    let paymentLabel = UILabel()
    let paymentSeperatorView = UIView()
    
    let driverTitleLabel = UILabel()
    let driverLabel = UILabel()
    let driverSeperatorView = UIView()
    
    let carLabel = UILabel()
    let carSeperatorView = UIView()
    
    let phoneNumberLabel = UILabel()
    let phoneSeperatorView = UIView()
    
    
    lazy var firstStackView = UIStackView(arrangedSubviews: [tarifTitleLabel, tarifLabel, tarifSeperatorView, priceLabel, priceSeperatorView, paymentTitleLabel, paymentLabel, paymentSeperatorView, driverTitleLabel, driverLabel, driverSeperatorView, carLabel, carSeperatorView, phoneNumberLabel, phoneSeperatorView])
    
    var historyModel : HistoryDetailDataViewModel? {
        didSet {
            generateCell()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        
        contentView.addSubview(pointsContainerView)
        contentView.addSubview(firstStackView)
        
        [dateLabel, declinedByLabel, firstSeperatorView, aPointStackView, bPointStackView].forEach { (view) in
            pointsContainerView.addSubview(view)
        }
        
        pointsContainerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 150)
        dateLabel.setAnchor(top: pointsContainerView.topAnchor, left: pointsContainerView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        declinedByLabel.setAnchor(top: pointsContainerView.topAnchor, left: nil, bottom: nil, right: pointsContainerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        firstSeperatorView.setAnchor(top: dateLabel.bottomAnchor, left: pointsContainerView.leftAnchor, bottom: nil, right: pointsContainerView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        aPointStackView.setAnchor(top: firstSeperatorView.bottomAnchor, left: pointsContainerView.leftAnchor, bottom: nil, right: pointsContainerView.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        bPointStackView.setAnchor(top: aPointStackView.bottomAnchor, left: pointsContainerView.leftAnchor, bottom: nil, right: pointsContainerView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
        
        firstStackView.setAnchor(top: pointsContainerView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingBottom: -12, paddingRight: 24)
        
      
       
    }
    
    private func configureViews(){
        [firstSeperatorView, tarifSeperatorView, paymentSeperatorView,
         priceSeperatorView, driverSeperatorView, carSeperatorView, phoneSeperatorView].forEach { (view) in
            view.backgroundColor = Colors.yassySeperatorGray
            view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
        
        declinedByLabel.font = .systemFont(ofSize: 14)
        declinedByLabel.textColor = UIColor.yassyOrange
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textAlignment = .left
        
        [grayImageView, orangeImageView].forEach { (view) in
            view.contentMode = .scaleAspectFit
            view.heightAnchor.constraint(equalToConstant: 18).isActive = true
            view.widthAnchor.constraint(equalToConstant: 18).isActive = true
        }
        
        [tarifTitleLabel, paymentTitleLabel, driverTitleLabel].forEach { (label) in
            label.textAlignment = .left
            label.textColor = .lightGray
            label.font = .systemFont(ofSize: 14)
        }
        
        tarifTitleLabel.text = "Тариф"
        paymentTitleLabel.text = "Способ оплаты"
        driverTitleLabel.text = "Водитель"
        
        [aPointAddressLabel, bPointAddressLabel, tarifLabel, priceLabel,
         paymentLabel, driverLabel, carLabel, phoneNumberLabel].forEach { (label) in
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 16)
        }
        
        
        [aPointStackView, bPointStackView].forEach { (stack) in
            stack.axis = .horizontal
            stack.alignment = .leading
            stack.distribution = .fillProportionally
        }
        
        firstStackView.axis = .vertical
        firstStackView.spacing = 16
        
       
    }
    
    func generateCell(){
        aPointAddressLabel.text = historyModel?.firstAddress
        bPointAddressLabel.text = historyModel?.secondAddress
        tarifLabel.text = historyModel?.serviceType
        priceLabel.text = historyModel?.tripTotalPrice
        driverLabel.text = historyModel?.driverName
        carLabel.text = historyModel?.driverCarName
        phoneNumberLabel.text = historyModel?.driverPhoneNumber
        declinedByLabel.text = historyModel?.cancelledBy
        paymentLabel.text = historyModel?.paymentMethod
        dateLabel.text = historyModel?.orderDate
    }
}

extension UIButton {
    func buttonLeftImagee(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func buttonCenterImagee(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .center
        self.imageView?.contentMode = .scaleAspectFit
    }
}
