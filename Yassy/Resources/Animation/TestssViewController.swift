//
//  TestViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 19.05.2021.
//

import UIKit

class TanirbergenView: UIViewController {
    let testView = SomeAwesomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(testView)
        testView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        testView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        testView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        testView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        testView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
