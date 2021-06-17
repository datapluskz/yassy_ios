//
//  MyFloatingPanelLayout.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 15.05.2021.
//

import UIKit
import FloatingPanel

class MyFloatingPanelLayout: FloatingPanelBottomLayout{
    override var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .medium: FloatingPanelLayoutAnchor(fractionalInset: 0.2, edge: .bottom, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea)
//            .didar: FloatingPanelLayoutAnchor(fractionalInset: -1, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

extension FloatingPanelState {
    static let start: FloatingPanelState = FloatingPanelState(rawValue: "lastQuart", order: 900)
    static let medium: FloatingPanelState = FloatingPanelState(rawValue: "medium", order: 400)
    static let finish: FloatingPanelState = FloatingPanelState(rawValue: "finish", order: 200)
//    static let didar: FloatingPanelState = FloatingPanelState(rawValue: "didar", order: -100)
}

