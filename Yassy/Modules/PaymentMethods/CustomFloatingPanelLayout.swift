//
//  CustomFloatingPanelLayout.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/12/21.
//

import Foundation
import FloatingPanel

class CustomFloatingPanelLayout: FloatingPanelBottomLayout{
    override var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.3, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}
