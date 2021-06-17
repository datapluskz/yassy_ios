//
//  TestViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 07.05.2021.
//

import UIKit

class TestViewController: UIViewController {
    
    let ended = EndedView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(ended)
        ended.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        setup()
    }
    
    fileprivate func setup() {
        ended.handleMainButton.addTarget(self, action: #selector(handleCheck), for: .touchUpInside)
    }
    
    @objc fileprivate func handleCheck() {
        dismiss(animated: true, completion: nil)
    }

}
