//
//  StandardCarView.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 27.02.2021.
//

import UIKit

class StandardCarView: UIView, SetupView {
    // MARK: - Properties
    lazy var gradeLabel = UILabel()
    lazy var pricaNumberLabel = UILabel()
    lazy var gradeImage = UIImageView(image: #imageLiteral(resourceName: "car").withRenderingMode(.alwaysOriginal))
   
        let infoButton = UIButton(type: .system)
  
    // MARK: - StackView
    
    lazy var gradeStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            gradeLabel,
            infoButton
        ])
        sv.spacing = -20
        sv.axis = .horizontal
        return sv
    }()
    
    lazy var stackLabel: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            gradeStack,
            pricaNumberLabel
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    // MARK:- Methods
    func setupView() {
        
        configureView()
        setupAction()
        /// setup
        [stackLabel, gradeImage].forEach {
            addSubview($0)
        }
        
        stackLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        stackLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gradeImage.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        
      
    }
    
    func configureView() {
        /// configure view
        configureLayerView(radius: 12)
        
        shadowView()
        layer.borderWidth = 1
        layer.borderColor = UIColor.yassyOrange.cgColor
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        gradeLabel.configureLabel(text: GRADE_LABEL, textColor: .black, textAlignment: .natural, fontName: "", fontSize: 14, numberOfLines: 0)
        pricaNumberLabel.configureLabel(text: GRADE_PRICE_LABEL, textColor: .black, textAlignment: .natural, fontName: "", fontSize: 20, numberOfLines: 0)
        
        infoButton.setImage(#imageLiteral(resourceName: "information_icon").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func setupAction() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
