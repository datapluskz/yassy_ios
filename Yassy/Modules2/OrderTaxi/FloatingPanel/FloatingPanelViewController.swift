//
//  FloatingPanelViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 27.02.2021.
//

import UIKit
import FloatingPanel

class FloatingPanelViewController: UIViewController, SetupView {

    // MARK: - Properties
    lazy var addressView = AddressView()
    lazy var standardCarView = StandardCarView()
    lazy var comfortCarView = ComfortCarView()
    lazy var footerOrderView = FooterOrderView()
    lazy var firstView = UIView()
    var checkState: ((Bool) -> ())?
    lazy var showDissMiss = false
    lazy var footerView = FooterOrderView()
    var actionHandler: (() -> Void)?
    // MARK: - Stack
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            standardCarView,
            comfortCarView
        ])
        sv.axis = .horizontal
        sv.spacing = 20
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var stackGradeView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [
            standardCarView,
            comfortCarView
        ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 12
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    func setupView() {
        /// setup
        [firstView, addressView, stackGradeView, footerOrderView].forEach {
            view.addSubview($0)
        }
        setupAction()
        firstView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        /// VIew Position
        addressView.anchor(top: firstView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 25, bottom: 0, right: 25))
        stackGradeView.anchor(top: addressView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 24, bottom: 0, right: 24))
        footerOrderView.anchor(top: stackGradeView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        /// TextField Position
    }
    
    func configureView() {
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        firstView.heightAnchor.constraint(equalToConstant: 16).isActive = true
      //  firstView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        firstView.backgroundColor = .clear
        /// configure View
        setupView()
        /// configure TextField
        
    }
    
    func setupAction() {
        let standardViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleChoseStandardView))
        standardCarView.addGestureRecognizer(standardViewGesture)
        
        let comfortViewGesture = UITapGestureRecognizer(target: self, action: #selector(handleChoseComfortView))
        comfortCarView.addGestureRecognizer(comfortViewGesture)
        
        footerOrderView.choseVariantsButton.addTarget(self, action: #selector(handleShowAddCard), for: .touchUpInside)
        
        footerOrderView.addCardButton.addTarget(self, action: #selector(handleShowAddCardView), for: .touchUpInside)
        footerOrderView.orderButton.addTarget(self, action: #selector(HandleShowState), for: .touchUpInside)
    }
    
    /// standard gesture
    @objc fileprivate func handleChoseStandardView() {
        standardGradeIsChose()
    }
    
    /// comfort gesture
    @objc fileprivate func handleChoseComfortView() {
        comfortGradeIsChose()
    }
    
    /// addCardAction
    @objc fileprivate func handleShowAddCard() {
        
        UIView.animate(withDuration: 0.5) { [self] in
            
            [footerOrderView.orderButton, footerOrderView.addCardButton].forEach { (subview) in
                subview.removeFromSuperview()
            }
            
            [footerOrderView.orderButton, footerOrderView.addCardButton].forEach {
                view.addSubview($0)
            }
            
            //footerOrderView.configureChoseOrderButton()
            footerOrderView.addCardButton.anchor(top: footerOrderView.choseVariantsButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
            
            footerOrderView.orderButton.anchor(top: footerOrderView.addCardButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 25, bottom: 0, right: 25))
        }
    }
    
    @objc fileprivate func HandleShowState() {
        checkState?(true)
    }
    
    @objc func didTapOkButton(_ button: UIButton) {
        actionHandler?()
        dismiss(animated: true)
    }
    
    public func actionHandler(handler: @escaping (() -> ())) {
        actionHandler = handler
    }
    /// showCardView
    @objc fileprivate func handleShowAddCardView() {
        print("1")
        let vc = CardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func searchTaxi() {
// //      let orderVC = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()))
//        let vc = SearchViewController(viewModel: MainViewModel(dataManager: DataManager()))
////        vc.s_lat = orderVC.firstLat
////        vc.s_lon = orderVC.firstLon
////        vc.d_lat = orderVC.secondLat
////        vc.d_lon = orderVC.secondLon
////        vc.distance = orderVC.distance.first!
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}
