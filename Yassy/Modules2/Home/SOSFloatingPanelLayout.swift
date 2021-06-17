//
//  SOSFloatingPanelLayout.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/12/21.
//

import Foundation
import FloatingPanel

class SOSFloatingPanelLayout: FloatingPanelBottomLayout{
    override var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}

class CarsFloatingPanelLayout: FloatingPanelBottomLayout{
    override var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.55, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}
