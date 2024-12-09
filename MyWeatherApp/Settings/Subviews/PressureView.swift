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
    
    private var pressureLabel =  UILabel()
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
            pressureImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            pressureImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            pressureImage.widthAnchor.constraint(equalToConstant: 30),
            pressureImage.heightAnchor.constraint(equalToConstant: 30),
            
            pressureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            pressureLabel.leadingAnchor.constraint(equalTo: pressureImage.trailingAnchor, constant: 10),
            
            segmentPicker.topAnchor.constraint(equalTo: pressureImage.bottomAnchor, constant: 20),
            segmentPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            segmentPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            segmentPicker.heightAnchor.constraint(equalToConstant: 50)
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
            print("°C")
        }
    }
}
