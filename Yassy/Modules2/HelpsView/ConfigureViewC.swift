//
//  ConfigureViewC.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 20.05.2021.
//

import UIKit

class ConfigureViewC: UIViewController {
    let testView = YassyNotWorking()
    let sizeScrean = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupView()
    }
    
    private func setupView() {
        [testView].forEach {
            view.addSubview($0)
        }   
        testView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - sizeScrean, width: view.frame.size.width, height: view.frame.size.height)
        animationConfigure()
    }
    
    private func animationConfigure() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIView.animate(withDuration: 0.4, delay: 0.5, options: .curveEaseInOut, animations: { [self] in
                testView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height)
                testView.layoutIfNeeded()
            }, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseOut, animations: { [self] in
                //testView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - sizeScrean, width: view.frame.size.width, height: view.frame.size.height)
                testView.alpha = 0
                testView.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
