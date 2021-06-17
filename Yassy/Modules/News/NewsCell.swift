//
//  NewsCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class NewsCell: BaseTableViewCell {
    override class func description() -> String {
        return "NewsCell"
    }
    
    let containerView = UIView()
    lazy var newsImageView = CustomRoundedImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width - 32, height: 140))
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    
    let calendarIconImageView = UIImageView()
   
    
    override func setupViews() {
        super.setupViews()
        configureView()
        contentView.addSubview(containerView)
        containerView.addSubview(newsImageView)
        containerView.addSubview(calendarIconImageView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(titleLabel)
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: -16, paddingRight: 16, height: 260)
        newsImageView.setAnchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 140)
        
        calendarIconImageView.setAnchor(top: newsImageView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        dateLabel.setAnchor(top: nil, left: calendarIconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0)
        dateLabel.centerYAnchor.constraint(equalTo: calendarIconImageView.centerYAnchor).isActive = true
        
        titleLabel.setAnchor(top: dateLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 0)
    }
    
    private func configureView(){
        containerView.backgroundColor = .white
        containerView.setCellShadowTwo()
        containerView.layer.cornerRadius = 20
        calendarIconImageView.contentMode = .scaleAspectFit
        calendarIconImageView.image = UIImage(named: "ic_calendar")?.withTintColor(.yassyLight)
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .left
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textAlignment = .left
    }
    
    
    func generateCell(_ model: NewsModel){
        if let url = URL(string: model.image){
            newsImageView.loadImage(from: url)
        }
        dateLabel.text = model.expiry_date
        titleLabel.text = model.description
    }
    
}
