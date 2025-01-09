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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConstraints()
        setUI()
        setSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        self.addSubview(temperatureLabel)
        self.addSubview(temperatureImage)
    }
    
    private func makeConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            temperatureImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            temperatureImage.widthAnchor.constraint(equalToConstant: 20),
            temperatureImage.heightAnchor.constraint(equalToConstant: 30),
            
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: temperatureImage.trailingAnchor, constant: 10),
        ])
    }
    
    private func setUI() {
        self.backgroundColor = SettingsColors.lighterBackgroundColor
        
        temperatureImage.image = UIImage(systemName: "thermometer.variable")
        temperatureImage.tintColor = SettingsColors.textColor
        temperatureLabel.text = "Температура"
        temperatureLabel.font = UIFont.systemFont(ofSize: 19)
        temperatureLabel.textColor = SettingsColors.textColor
    }
    private func setSegmentedControl() {
        let setting = getCurrentSetting()
        let customSegmenredControl = CustomSegmentedControl(Constants.options[0],Constants.options[1],grade: SettingsData.Grades.temp, key: SettingsData.Keys.tempSettrings,currentSetting: setting)
        self.addSubview(customSegmenredControl)
        
        NSLayoutConstraint.activate([
        customSegmenredControl.topAnchor.constraint(equalTo: temperatureImage.bottomAnchor, constant: 15),
        customSegmenredControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        customSegmenredControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        customSegmenredControl.heightAnchor.constraint(equalToConstant: 40),
        ])
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
