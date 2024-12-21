//
//  windView.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 09.12.2024.
//

import UIKit

private enum Constants {
    static let options = ["гПа","мм рт. ст","мбар","дюйм рт. ст."]
}

class PressureView: UIView {
    let manager = UDStrorageManager.shared
    private var pressureLabel = UILabel()
    private var pressureImage = UIImageView()
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
        self.addSubview(pressureLabel)
        self.addSubview(pressureImage)
        self.addSubview(segmentPicker)
    }
    
    private func makeConstraints() {
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureImage.translatesAutoresizingMaskIntoConstraints = false
        segmentPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pressureImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            pressureImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            pressureImage.widthAnchor.constraint(equalToConstant: 30),
            pressureImage.heightAnchor.constraint(equalToConstant: 30),
            
            pressureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            pressureLabel.leadingAnchor.constraint(equalTo: pressureImage.trailingAnchor, constant: 10),
            
            segmentPicker.topAnchor.constraint(equalTo: pressureImage.bottomAnchor, constant: 15),
            segmentPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            segmentPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            segmentPicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUI() {
        self.backgroundColor = SettingsColors.lighterBackgroundColor
        
        pressureImage.image = UIImage(systemName: "barometer")
        pressureImage.tintColor = SettingsColors.textColor
        pressureLabel.text = "Давление"
        pressureLabel.font = UIFont.systemFont(ofSize: 19)
        pressureLabel.textColor = SettingsColors.textColor
        
#warning ("почему то не меняется цвет ширина и края")
        segmentPicker.selectedSegmentIndex = getCurrentSetting()
        segmentPicker.backgroundColor = .clear
        segmentPicker.layer.cornerRadius = 30
        segmentPicker.layer.borderWidth = 1
        segmentPicker.layer.borderColor = SettingsColors.evenLighterBackgroundColor.cgColor
    }
    
    private func setActions() {
        segmentPicker.addTarget(self,action: #selector(selectPressure),for: .valueChanged)
    }
 
    @objc private func selectPressure() {
        switch segmentPicker.selectedSegmentIndex {
        case 0:
            manager.didChangeSettings(value: SettingsData.pressureGrade.gPa.rawValue, key: SettingsData.Keys.pressureSettrings)
        case 1:
            manager.didChangeSettings(value: SettingsData.pressureGrade.mmRtSt.rawValue, key: SettingsData.Keys.pressureSettrings)
        case 2:
            manager.didChangeSettings(value: SettingsData.pressureGrade.mBar.rawValue, key: SettingsData.Keys.pressureSettrings)
        case 3:
            manager.didChangeSettings(value: SettingsData.pressureGrade.dRtSt.rawValue, key: SettingsData.Keys.pressureSettrings)
        default:
            print("°C")
        }
    }
    
    private func getCurrentSetting() -> Int {
        let currentSetting = manager.getCurrentSettings(for: SettingsData.Keys.pressureSettrings)
        switch currentSetting {
        case SettingsData.pressureGrade.gPa.rawValue:
            return 0
        case SettingsData.pressureGrade.mmRtSt.rawValue:
            return 1
        case SettingsData.pressureGrade.mBar.rawValue:
            return 2
        case SettingsData.pressureGrade.dRtSt.rawValue:
            return 3
        default:
           return 0
        }
    }
}
