//
//  TempView.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 17.12.2024.
//

import UIKit

private enum Constants {
    static let options = [SettingsData.tempGrade.celsius.rawValue,SettingsData.tempGrade.fahrenheit.rawValue]
}

class TempView: UIView {
    let manager = UDStrorageManager.shared
    private var temperatureLabel =  UILabel()
    private var temperatureImage = UIImageView()
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
        self.addSubview(temperatureLabel)
        self.addSubview(temperatureImage)
        self.addSubview(segmentPicker)
    }
    
    private func makeConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureImage.translatesAutoresizingMaskIntoConstraints = false
        segmentPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            temperatureImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            temperatureImage.widthAnchor.constraint(equalToConstant: 20),
            temperatureImage.heightAnchor.constraint(equalToConstant: 30),
            
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 10),
            
            segmentPicker.topAnchor.constraint(equalTo: temperatureImage.bottomAnchor, constant: 15),
            segmentPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            segmentPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            segmentPicker.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setUI() {
        self.backgroundColor = SettingsColors.lighterBackgroundColor
        
        temperatureImage.image = UIImage(systemName: "thermometer.variable")
        temperatureImage.tintColor = SettingsColors.textColor
        temperatureLabel.text = "Температура"
        temperatureLabel.font = UIFont.systemFont(ofSize: 19)
        temperatureLabel.textColor = SettingsColors.textColor
        
        segmentPicker.selectedSegmentIndex = getCurrentSetting()
        segmentPicker.backgroundColor = .clear
        segmentPicker.layer.borderWidth = 1
        segmentPicker.layer.borderColor = SettingsColors.evenLighterBackgroundColor.cgColor
    }
    
    private func setActions() {
        segmentPicker.addTarget(self,action: #selector(selectTemp),for: .valueChanged)
    }
    
    @objc private func selectTemp() {
        switch segmentPicker.selectedSegmentIndex {
        case 0:
            manager.didChangeSettings(value: SettingsData.tempGrade.celsius.rawValue, key: SettingsData.Keys.tempSettrings)
        case 1:
            manager.didChangeSettings(value: SettingsData.tempGrade.fahrenheit.rawValue, key: SettingsData.Keys.tempSettrings)
        default:
            print("°C")
        }
    }
    private func getCurrentSetting() -> Int {
        let currentSetting = manager.getCurrentSettings(for: SettingsData.Keys.tempSettrings)
        if currentSetting == SettingsData.tempGrade.celsius.rawValue {
            return 0
        } else {
            return 1
        }
    }
}
