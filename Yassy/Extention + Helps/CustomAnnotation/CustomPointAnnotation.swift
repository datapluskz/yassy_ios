//
//  C.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 14.05.2021.
//
import UIKit
import Foundation
import Mapbox

class CustomPointAnnotation : NSObject, MGLAnnotation {
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    // Custom properties that we will use to customize the annotation's image.
    var image: UIImage?
    var reuseIdentifier: String?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
