//
//  DetailViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 06.05.2021.
//

import UIKit

class DetailViewController: UIViewController {
    let image = UIImageView(image: #imageLiteral(resourceName: "Снимок экрана 2021-05-06 в 08.42.51").withRenderingMode(.alwaysOriginal))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        setupLoading(timer: 2, centerY: 0)
        view.addSubview(image)
        image.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
