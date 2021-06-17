//
//  RatingView.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 07.05.2021.
//

import UIKit

class RatingView: UIView {
    
    lazy var string = UILabel()
    lazy var subString = UILabel()
    
    lazy var firstButton = UIButton(type: .system)
    lazy var secondButton = UIButton(type: .system)
    lazy var thirdButton = UIButton(type: .system)
    lazy var fourthButton = UIButton(type: .system)
    lazy var fifthButton = UIButton(type: .system)
    lazy var finishButton = UIButton(type: .system)
    
    var checkVar = 0
    
    lazy var stackLabel: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            string,
            subString
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    lazy var stackButton: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            firstButton,
            secondButton,
            thirdButton,
            fourthButton,
            fifthButton
        ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    private func setupView() {
        backgroundColor = .white
        addLayouts()
    }
    
    private func addLayouts() {
        [stackLabel, stackButton, finishButton].forEach {
            addSubview($0)
        }
        
        stackLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        stackLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        stackButton.anchor(top: stackLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        stackButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        [firstButton, secondButton, thirdButton, fourthButton, fifthButton].forEach { size in
            size.widthAnchor.constraint(equalToConstant: 60).isActive = true
            size.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        finishButton.anchor(top: stackButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 32, bottom: 0, right: 32))
        
        configureLayouts()
        setupActionForButtons()
    }
    
    private func configureLayouts() {
        string.configureLabel(text: "Поездка завершена", textColor: .black, textAlignment: .center, fontName: "", fontSize: 23, numberOfLines: 0)
        subString.configureLabel(text: "Оцените поездку", textColor: .lightGray, textAlignment: .center, fontName: "", fontSize: 20, numberOfLines: 0)
        
        firstButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        firstButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        secondButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        secondButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        thirdButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        thirdButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        fourthButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        fourthButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        fifthButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        fifthButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        
        finishButton.configureButton(title: "Готова", titleColor: .white, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
        finishButton.shadowView()
    }
    
    private func setupActionForButtons() {
        firstButton.addTarget(self, action: #selector(First), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(Second), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(Third), for: .touchUpInside)
        fourthButton.addTarget(self, action: #selector(Fourh), for: .touchUpInside)
        fifthButton.addTarget(self, action: #selector(Fifth), for: .touchUpInside)
    }
    
    @objc fileprivate func First() {
        UIView.animate(withDuration: 0.5) { [self] in
            if checkVar % 2 == 1 {
                checkVar += 1
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                checkVar -= 1
            }
            layoutIfNeeded()
        }
    }
    
    @objc fileprivate func Second() {
        UIView.animate(withDuration: 0.5) { [self] in
            if checkVar % 2 == 1 {
                checkVar += 1
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                checkVar -= 1
            }
            layoutIfNeeded()
        }
    }
    
    @objc fileprivate func Third() {
        UIView.animate(withDuration: 0.5) { [self] in
            if checkVar % 2 == 1 {
                checkVar += 1
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                checkVar -= 1
            }
            layoutIfNeeded()
        }
    }
    
    @objc fileprivate func Fourh() {
        UIView.animate(withDuration: 0.5) { [self] in
            if checkVar == 0 {
                checkVar += 1
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                fourthButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                fourthButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                checkVar -= 1
            }
            layoutIfNeeded()
        }
    }
    
    @objc fileprivate func Fifth() {
        UIView.animate(withDuration: 0.5) { [self] in
            if checkVar == 0 {
                checkVar += 1
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                fourthButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
                fifthButton.setImage(#imageLiteral(resourceName: "rating_icon").withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                firstButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                fourthButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                fifthButton.setImage(#imageLiteral(resourceName: "rating_icon1").withRenderingMode(.alwaysOriginal), for: .normal)
                checkVar -= 1
            }
            layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
