//
//  DeviceToken.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.04.2021.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
