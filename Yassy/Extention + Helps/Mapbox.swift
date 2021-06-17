//
//  Mapbox.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 14.05.2021.
//

import UIKit

extension UIViewController {
    func setupMarker(marker: UIImage) {
        let marker = UIImageView(image: marker)
        view.addSubview(marker)
        marker.center = view.center
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard self == self else { return }
            marker.frame.origin.y -= 20
        } completion: { (_) in
            UIView.animateKeyframes(withDuration: 1, delay: 0.5, options: [.autoreverse, .repeat], animations: {
                marker.frame.origin.y += 20
            }, completion: nil)
        }
    }
}
