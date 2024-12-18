//
//  Untitled.swift
//  MyWeatherApp
//
//  Created by Алина Класс on 09.12.2024.
//

import UIKit

private enum Constants {
    static let options = ["м/с","км/ч","миль/ч","узлы"]
}

class WindView: UIView {
    
    private var WindLabel =  UILabel()
    private var WindImage = UIImageView()
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
        self.addSubview(WindLabel)
        self.addSubview(WindImage)
        self.addSubview(segmentPicker)
    }
    
    private func makeConstraints() {
        WindLabel.translatesAutoresizingMaskIntoConstraints = false
        WindImage.translatesAutoresizingMaskIntoConstraints = false
        segmentPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            WindImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            WindImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            WindImage.widthAnchor.constraint(equalToConstant: 30),
            WindImage.heightAnchor.constraint(equalToConstant: 30),
            
            WindLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            WindLabel.leadingAnchor.constraint(equalTo: WindImage.trailingAnchor, constant: 10),
            
            segmentPicker.topAnchor.constraint(equalTo: WindImage.bottomAnchor, constant: 15),
            segmentPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            segmentPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            segmentPicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setUI() {
        self.backgroundColor = SettingsColors.lighterBackgroundColor
        
        WindImage.image = UIImage(systemName: "wind")
        WindImage.tintColor = SettingsColors.textColor
        WindLabel.text = "Сила ветра"
        WindLabel.font = UIFont.systemFont(ofSize: 19)
        WindLabel.textColor = SettingsColors.textColor
        
#warning ("почему то не меняется цвет ширина и края")
        segmentPicker.selectedSegmentIndex = 0
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
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        case 3:
            print("3")
        default:
            print("0")
        }
    }
    private func getCurrentSetting() -> Int {
        let currentSetting = manager.getCurrentSettings(for: SettingsData.Keys.windSettrings)
        switch currentSetting {
        case SettingsData.windGrade.ms.rawValue:
            return 0
        case SettingsData.windGrade.kmh.rawValue:
            return 1
        case SettingsData.windGrade.milesh.rawValue:
            return 2
        case SettingsData.windGrade.knots.rawValue:
            return 3
        default:
           return 0
        }
    }
}

