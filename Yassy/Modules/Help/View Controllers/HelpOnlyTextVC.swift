//
//  HelpOnlyTextVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/30/21.
//

import UIKit

class HelpOnlyTextVC: UIViewController {
    
    var navigationTitle: String
    var descriptionText: String
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 14)
        view.showsVerticalScrollIndicator = true
        view.isEditable = false
        view.isScrollEnabled = true
        return view
    }()
    
    init(navigationTitle: String, descriptionText: String){
        self.navigationTitle = navigationTitle
        self.descriptionText = descriptionText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        textView.text = descriptionText
        view.addSubview(textView)
        textView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
    }
    
    private func setupNavigationBar(){
        navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.title = navigationTitle
    }

}
