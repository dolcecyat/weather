//
//  CustomSegmentedControl.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 04.01.2025.
//

import Foundation
import UIKit

class CustomSegmentedControl: UIView {
    private let stackView = UIStackView()
    private let selectedView = UIView()
    private var grade: SettingsData.Grades?
 
    private var widthConstraint = NSLayoutConstraint()
    private var leadingConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackView()
        configureSelectedView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ titlesForButtons: String...,grade: SettingsData.Grades,key: SettingsData.Keys, currentSetting: Int) {
        self.init()
        self.grade = grade
        titlesForButtons.enumerated().forEach {
            let button: UIButton = .createSegmentedButton(title: $0.element)
            button.tag = $0.offset
            button.addTarget(self, action: #selector(segmentedButtonAction), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        DispatchQueue.main.async {
            self.widthConstraint.constant = self.stackView.arrangedSubviews[currentSetting].frame.width
            self.leadingConstraint.constant = self.stackView.arrangedSubviews[currentSetting].frame.origin.x
        }
    }

    @objc private func segmentedButtonAction(sender: UIButton) {
        widthConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.width
        leadingConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        switch grade {
        case .temp:
            switch sender.tag {
            case 0:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.tempGrade.celsius.rawValue, key: SettingsData.Keys.tempSettrings)
                print("0")
            case 1:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.tempGrade.fahrenheit.rawValue, key: SettingsData.Keys.tempSettrings)
                print("1")

            default:
                print("Unknown button tapped")
            }
        case .pressure:
            switch sender.tag {
            case 0:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.pressureGrade.gPa.rawValue, key: SettingsData.Keys.pressureSettrings)
            case 1:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.pressureGrade.mmRtSt.rawValue, key: SettingsData.Keys.pressureSettrings)
            case 2:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.pressureGrade.mBar.rawValue, key: SettingsData.Keys.pressureSettrings)
            case 3:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.pressureGrade.dRtSt.rawValue, key: SettingsData.Keys.pressureSettrings)
            default:
                print("Unknown button tapped")
            }
        case .wind:
            switch sender.tag {
            case 0:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.windGrade.ms.rawValue, key: SettingsData.Keys.windSettrings)
            case 1:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.windGrade.kmh.rawValue, key: SettingsData.Keys.windSettrings)
            case 2:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.windGrade.milesh.rawValue, key: SettingsData.Keys.windSettrings)
            case 3:
                UDStrorageManager.shared.didChangeSettings(value: SettingsData.windGrade.knots.rawValue, key: SettingsData.Keys.windSettrings)
            default:
                print("Unknown button tapped")
            }
        case .style:
            print("style")
        case .none:
            print("none")
            
        }
    }
}

private extension CustomSegmentedControl {
    func configure() {
        layer.borderColor = SettingsColors.evenLighterBackgroundColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
        backgroundColor = SettingsColors.lighterBackgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }
    
    func configureSelectedView() {
        selectedView.backgroundColor = SettingsColors.evenLighterBackgroundColor
        selectedView.layer.cornerRadius = 15
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(selectedView)
    }
    
    func setConstraints() {
        widthConstraint = selectedView.widthAnchor.constraint(equalToConstant: 0)
        leadingConstraint = selectedView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        widthConstraint.isActive = true
        leadingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),

            selectedView.topAnchor.constraint(equalTo: stackView.topAnchor),
            selectedView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
        ])
    }
}
