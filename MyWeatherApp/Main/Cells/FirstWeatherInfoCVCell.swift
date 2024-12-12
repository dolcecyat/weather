//
//  FirstWeatherInfoCVCell.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 03.12.2024.
//

import Foundation
import UIKit

class FirstWeatherInfoCVCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    private var cellFrame = UIView()
    private var weatherImage = UIImageView()
    private var feelLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var mainInfoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViews()
        setConstraints()
        setUI()
    }
    
    private func addViews() {
        contentView.addSubview(cellFrame)
        contentView.addSubview(weatherImage)
        cellFrame.addSubview(feelLabel)
        cellFrame.addSubview(temperatureLabel)
        cellFrame.addSubview(mainInfoLabel)
    }
    
    private func setConstraints() {
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        feelLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        mainInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
//            cellFrame.heightAnchor.constraint(equalToConstant: 300),
            
            feelLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 20),
            feelLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 20),
            
            temperatureLabel.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor,constant: 30),
            
            weatherImage.topAnchor.constraint(equalTo: feelLabel.bottomAnchor,constant: 10),
            weatherImage.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor,constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            weatherImage.widthAnchor.constraint(equalToConstant: 65),
            
            mainInfoLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            mainInfoLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor,constant: 20),
            mainInfoLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = .clear
        cellFrame.backgroundColor = .clear
        
        cellFrame.layer.cornerRadius = 32
        cellFrame.layer.borderColor = MainColors.lighterBackgroundColor
        cellFrame.layer.borderWidth = 2.0
        
        feelLabel.font = .systemFont(ofSize: 15)
        feelLabel.textColor = UIColor(cgColor: MainColors.textColor)
        
        temperatureLabel.font = .systemFont(ofSize: 40)
        temperatureLabel.textColor = UIColor(cgColor: MainColors.lighterTextColor)
        temperatureLabel.text = "0"
        
        mainInfoLabel.font = .systemFont(ofSize: 20)
        mainInfoLabel.textColor = UIColor(cgColor: MainColors.lighterTextColor)
        mainInfoLabel.numberOfLines = 4
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.conditionImage
        feelLabel.text = model.detailInfo
        temperatureLabel.text = model.mainTemp
        mainInfoLabel.text = model.mainInfo
    }
}

