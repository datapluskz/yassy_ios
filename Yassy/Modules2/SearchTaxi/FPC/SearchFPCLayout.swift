//
//  SearchFPCLayout.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 19.05.2021.
//

import UIKit
import FloatingPanel

class SearchFpcLayout: FloatingPanelBottomLayout{
    override var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .startState: FloatingPanelLayoutAnchor(fractionalInset: 0.4, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

extension FloatingPanelState {
    static let startState: FloatingPanelState = FloatingPanelState(rawValue: "medium", order: 300)
}
