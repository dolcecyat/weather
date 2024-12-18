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
        
#warning ("почему то не меняется цвет ширина и края")
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
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("0")
        }
    }
}

