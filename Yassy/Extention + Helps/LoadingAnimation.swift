//
//  LoadingAnimation.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 02.05.2021.
//

import UIKit
import Lottie

extension UIViewController {
    
    func setupLoading(timer: Double, centerY: CGFloat) {
        let jsonName = "loading"
        let animation = Animation.named(jsonName)
        // loading Animation
        let animationView = AnimationView(animation: animation)
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        view.addSubview(animationView)
        animationView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        animationView.backgroundColor = .white
        animationView.shadowView()
        animationView.layer.cornerRadius = 15
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.play()
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + timer) {
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self = self else { return }
                animationView.stop()
                animationView.backgroundColor = .clear
                animationView.hideShadowView()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func setupTaxiLoading(timer: Double) {
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.showAlert(alertString: "К сожалению, свободных такси нет")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.4) { [weak self] in
                guard let self = self else { return }
                let navigationController = UINavigationController(rootViewController: OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false))
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    func signalMap(timer: Double) {
        let jsonName = "signal"
        let animation = Animation.named(jsonName)
        let animationView = AnimationView(animation: animation)
        view.addSubview(animationView)
        animationView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        animationView.backgroundColor = .clear
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.animationSpeed = 0.6
        animationView.loopMode = .repeat(10)
        animationView.play()
    }
    
    func searchingTaxi(jsonName: String, check: Bool, centerY: CGFloat) {
        let animation = Animation.named(jsonName)
        // loading Animation
        let animationView = AnimationView(animation: animation)
        
        view.addSubview(animationView)
        animationView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        animationView.backgroundColor = .clear
        animationView.shadowView()
        animationView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
        if check == true {
            animationView.removeFromSuperview()
            animationView.stop()
        }
        }
    }
    
    func searchingIsEmty() {
        let jsonName = "searchingCars"
        let animation = Animation.named(jsonName)
        // loading Animation
        let animationView = AnimationView(animation: animation)
        
        view.addSubview(animationView)
        animationView.stop()
    }
}
