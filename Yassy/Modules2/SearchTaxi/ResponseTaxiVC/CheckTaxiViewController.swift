//
//  CheckTaxiViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 20.05.2021.
//

import UIKit
import Lottie

class CheckTaxiViewController: UIViewController {
    
    let viewModel: MainViewModel!
    let contentVC = OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: true)
    var isEmtyValue: ((String) -> ())?
    var timer = Timer()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        responseTaxi()
        setupLoadingView()
        showCars()
    }
    
    @objc func cycle() {

    }
    
    private func showCars() {
        
    }
    
    private func setupLoadingView() {
        let jsonName = "loading"
        let animation = Animation.named(jsonName)
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        view.addSubview(animationView)
        animationView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.play()
    }
    
    private func responseTaxi() {
        viewModel.searchTaxi(s_lat: "\(AddressInformation.s_lat)", s_lot: "\(AddressInformation.s_lon)", d_lat: "\(AddressInformation.d_lat)", d_lot: "\(AddressInformation.d_lon)", d_address: AddressInformation.d_address, s_address: AddressInformation.s_address, distance: "0.5") {  [weak self] (checked) in
                guard let self = self else { return }
            
            print(AddressInformation.s_lat)
            print(AddressInformation.s_lon)
            print(AddressInformation.s_address)
            print(AddressInformation.d_address)
                if checked {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let navigationController = UINavigationController(rootViewController: SearchViewController(dataManager: DataManager(), viewmodel: MainViewModel(dataManager: DataManager()), pulseCheck: true))
                        navigationController.modalTransitionStyle = .crossDissolve
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                }
                
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                        let navigationController = UINavigationController(rootViewController: self.contentVC)
                        navigationController.modalPresentationStyle = .fullScreen
                        navigationController.modalTransitionStyle = .crossDissolve
                        self.present(navigationController, animated: true, completion: nil)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
