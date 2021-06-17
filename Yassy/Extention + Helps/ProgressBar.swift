//
//  ProgressBar.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 25.03.2021.
//

import JGProgressHUD

extension UIViewController {
    func showProgress() {
        let hud = JGProgressHUD()
        hud.show(in: view.self)
        hud.dismiss(afterDelay: 3)
    }
}
