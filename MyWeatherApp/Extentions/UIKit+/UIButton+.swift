//
//  UIButton.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 09.01.2025.
//

import Foundation
import UIKit

extension UIButton {
    static func createSegmentedButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
      return button
    }
}
