//
//  HelperFloatingPanel.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 27.02.2021.
//

import UIKit

extension FloatingPanelViewController {
    
    func standardGradeIsChose() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.1, animations: { [self] in
                standardCarView.layer.borderColor = UIColor.yassyOrange.cgColor
                standardCarView.gradeLabel.textColor = .black
                
                comfortCarView.layer.borderColor = UIColor.yassyLight.cgColor
                comfortCarView.gradeLabel.textColor = .yassyLight
            }, completion: nil)
        }
    }
    
    func comfortGradeIsChose() {
        showAlert(alertString: "Этот раздел временно недоступен")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            UIView.animate(withDuration: 0.1, animations: { [self] in
////                standardCarView.layer.borderColor = UIColor..cgColor
////                standardCarView.gradeLabel.textColor = .black
//                //standardCarView.gradeImage.backgroundColor = .yassyLight
//                
//                comfortCarView.layer.borderColor = UIColor.yassyOrange.cgColor
//                comfortCarView.gradeLabel.textColor = .yassyLight
//            }, completion: nil)
//        }
    }
}
