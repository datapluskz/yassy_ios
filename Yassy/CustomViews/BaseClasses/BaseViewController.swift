//
//  BaseViewController.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/22/21.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {

    let menu = SideMenuNavigationController(rootViewController: TestMenuVC())
    let darkeningView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    let menuButton = UIButton(type: .system)
    
    func setupSideMenu(){
        menu.sideMenuDelegate = self
        navigationController?.transparentNavigationController()
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.width - 100
        let leftButton = UIBarButtonItem()
        setupMenuButtonConfiguration()
        leftButton.customView = menuButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setupMenuButtonConfiguration(){
        menuButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        menuButton.layer.cornerRadius = 9
        menuButton.backgroundColor = .white
        menuButton.setImage(#imageLiteral(resourceName: "ic_menu").withRenderingMode(.alwaysOriginal), for: .normal)
        menuButton.shadowView()
        menuButton.addTarget(self, action: #selector(showSideMenu), for: .touchUpInside)
    }
    
    @objc func showSideMenu(){
        present(menu, animated: true, completion: nil)
    }
    
}

extension BaseViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        view.addSubview(darkeningView)
        darkeningView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        darkeningView.removeFromSuperview()
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
}
