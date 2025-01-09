//
//  ModeView.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 10.12.2024.
//

import UIKit

private enum Constants {
    static let options = ["Светлое","Темное","Системное"]
}

class ModeView: UIView {
    let manager = UDStrorageManager.shared
    private var label =  UILabel()
    private var segmentPicker = UISegmentedControl(items: Constants.options)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConstraints()
        setUI()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(label)
        self.addSubview(segmentPicker)
    }
    
    private func makeConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        segmentPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            segmentPicker.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            segmentPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            segmentPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            segmentPicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUI() {
        self.backgroundColor = SettingsColors.lighterBackgroundColor

        label.text = "Оформление"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = SettingsColors.textColor
        
        segmentPicker.selectedSegmentIndex = 0
        segmentPicker.backgroundColor = .clear
        segmentPicker.layer.cornerRadius = 30
        segmentPicker.layer.borderWidth = 1
        segmentPicker.layer.borderColor = SettingsColors.evenLighterBackgroundColor.cgColor
    }
    
    private func setActions() {
        segmentPicker.addTarget(self,action: #selector(selectMode),for: .valueChanged)
    }
 
    @objc private func selectMode() {
        switch segmentPicker.selectedSegmentIndex {
        case 0:
            manager.didChangeSettings(value: SettingsData.styleGrade.light.rawValue, key: SettingsData.Keys.styleSettrings)
        case 1:
            manager.didChangeSettings(value: SettingsData.styleGrade.dark.rawValue, key: SettingsData.Keys.styleSettrings)
        case 2:
            manager.didChangeSettings(value: SettingsData.styleGrade.system.rawValue, key: SettingsData.Keys.styleSettrings)
        default:
            print("0")
        }
    }
    
    private func getCurrentSetting() -> Int {
        let currentSetting = manager.getCurrentSettings(for: SettingsData.Keys.styleSettrings)
        switch currentSetting {
        case SettingsData.styleGrade.light.rawValue:
            return 0
        case SettingsData.styleGrade.dark.rawValue:
            return 1
        case SettingsData.styleGrade.system.rawValue:
            return 2
        default:
           return 0
        }
    }
}
