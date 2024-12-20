//
//  Extentions.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 19.12.2024.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(view : UIView) {
        view.layer.cornerRadius = 20
    }
}

extension Int {
    func ctof (intC: Int) -> Int {
        let cToF = (intC * 9/5) + 32
        return cToF
    }
}

extension Double {
    func msToKmh(ms: Double) -> Double {
        let kmh = ms * 3.6
        return kmh
    }
    
    func msToMph(ms: Double) -> Double {
        let mph = ms * 2.236
        return mph
    }
    
    func msToknots(ms: Double) -> Double {
        let knots = ms * 1.9438
        return knots
    }
}

