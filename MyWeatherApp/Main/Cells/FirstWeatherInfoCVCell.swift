//
//  FirstWeatherInfoCVCell.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 03.12.2024.
//

import Foundation
import UIKit

private enum Constants {
    static let backgroundViewColor = CGColor(red: 0.21, green: 0.37, blue: 0.48, alpha: 1)
    static let lighterBackgroundColor = CGColor(red: 0.41, green: 0.61, blue: 0.74, alpha: 1)
    static let timeTextColor = CGColor(red: 0.67, green: 0.79, blue: 0.86, alpha: 1)
    static let temperatureTextColor = CGColor(red: 0.89, green: 0.93, blue: 0.95, alpha: 1)
}

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
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            
            feelLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 10),
            feelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -10),
            
            temperatureLabel.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor,constant: -10),
            
            weatherImage.topAnchor.constraint(equalTo: feelLabel.bottomAnchor,constant: 10),
            weatherImage.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor,constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 40),
            weatherImage.widthAnchor.constraint(equalToConstant: 40),
            
            mainInfoLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            mainInfoLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor,constant: -10),
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = .clear
        cellFrame.backgroundColor = .clear
        
        cellFrame.backgroundColor = UIColor(cgColor: Constants.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 20
        cellFrame.layer.borderColor = Constants.lighterBackgroundColor
        cellFrame.layer.borderWidth = 2.0
        
        feelLabel.font = .systemFont(ofSize: 10)
        feelLabel.textColor = UIColor(cgColor: Constants.timeTextColor)
        
        temperatureLabel.font = .systemFont(ofSize: 25)
        temperatureLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
        temperatureLabel.text = "0"
        
        mainInfoLabel.font = .systemFont(ofSize: 15)
        mainInfoLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.image
        feelLabel.text = model.detailInfo
        temperatureLabel.text = model.mainTemp
        mainInfoLabel.text = model.mainInfo
    }
}

