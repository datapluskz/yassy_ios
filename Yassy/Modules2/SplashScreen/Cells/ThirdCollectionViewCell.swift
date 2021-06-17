//
//  ThirdCollectionViewCell.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var imageView   = UIImageView(image: #imageLiteral(resourceName: "City driver-rafiki 2-1").withRenderingMode(.alwaysOriginal))
    private var titleLabel  = UILabel()
    private var subTitleLabel  = UILabel()
    public var nextPageButton = UIButton(type: .system)
    var isSmallDevice = UIScreen.main.bounds.height > 570.0
    
    
    // MARK: - Stack
    lazy var stackNotificationLabels: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitleLabel
        ])
        sv.axis    = .vertical
        sv.spacing = 8
        return sv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupSubviews()
        setupLayouts()
    }
    
    // MARK: - Methods
    private func setupSubviews() {
        addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        configureView()
    }
    
    private func configureView() {
        addSubview(imageView)
        imageView.configureSizeView(height: isSmallDevice ? 340 : 300, width: isSmallDevice ? 340 : 300)
    }
    
    private func setupLayouts() {
        addSubview(nextPageButton)
        nextPageButton.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 32, bottom: 80, right: 32))
        nextPageButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(stackNotificationLabels)
        stackNotificationLabels.anchor(top: nil, leading: nil, bottom: nextPageButton.topAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 32, right: 0))
        stackNotificationLabels.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        configureLayouts()
    }
    
    private func configureLayouts() {
        nextPageButton.configureButton(title: ONBOARDING_THIRD_PAGE_BUTTON, titleColor: .white, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: isSmallDevice ? 50 : 36, backgroundColor: .yassyOrange)
        titleLabel.configureLabel(text: ONBOARDING_THIRD_PAGE_TITLE, textColor: .black, textAlignment: .center, fontName: "SFProDisplay-Black", fontSize: isSmallDevice ? 24 : 16, numberOfLines: 0)
        subTitleLabel.configureLabel(text: ONBOARDING_THIRD_PAGE_SUB_TITLE, textColor: .lightGray, textAlignment: .center, fontName: "SFProDisplay-Black", fontSize: isSmallDevice ? 16 : 12, numberOfLines: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
