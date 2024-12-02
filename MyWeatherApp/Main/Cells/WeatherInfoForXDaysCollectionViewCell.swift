//
//  WeatherInfoForXDaysCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import UIKit

private enum Constants {
    static let backgroundViewColor = CGColor(red: 0.21, green: 0.37, blue: 0.48, alpha: 1)
    static let lighterBackgroundColor = CGColor(red: 0.41, green: 0.61, blue: 0.74, alpha: 1)
    static let timeTextColor = CGColor(red: 0.67, green: 0.79, blue: 0.86, alpha: 1)
    static let temperatureTextColor = CGColor(red: 0.89, green: 0.93, blue: 0.95, alpha: 1)
}

class WeatherInfoForXDaysCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var cellFrame = UIView()
    private var weatherImage = UIImageView()
    private var dayTempLabel = UILabel()
    private var nightTempLabel = UILabel()
    private var dateLabel = UILabel()
    
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
        cellFrame.addSubview(weatherImage)
        cellFrame.addSubview(dateLabel)
        cellFrame.addSubview(nightTempLabel)
        cellFrame.addSubview(dayTempLabel)
    
    }
    
    private func setConstraints() {
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        dayTempLabel.translatesAutoresizingMaskIntoConstraints = false
        nightTempLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellFrame.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: 20),
            cellFrame.heightAnchor.constraint(equalToConstant: 60),
            
            dateLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: -10),
            
            nightTempLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 10),
            nightTempLabel.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor,constant: -14),
            
            dayTempLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 10),
            dayTempLabel.trailingAnchor.constraint(equalTo: nightTempLabel.leadingAnchor,constant: -14),
            
            weatherImage.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 10),
            weatherImage.trailingAnchor.constraint(equalTo: dayTempLabel.leadingAnchor,constant: -14),
            weatherImage.heightAnchor.constraint(equalToConstant: 20),
            weatherImage.widthAnchor.constraint(equalToConstant: 20),
            
            ])
    }
    
    private func setUI() {
        contentView.backgroundColor = UIColor(cgColor:Constants.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: Constants.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 10
        
        dateLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
        dateLabel.font = .systemFont(ofSize: 14)
        
        dayTempLabel.font = .systemFont(ofSize: 14)
        dayTempLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
        
        nightTempLabel.font = .systemFont(ofSize: 14)
        dayTempLabel.textColor = UIColor(cgColor: Constants.timeTextColor)
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.image
        dateLabel.text = "2 декабря"
        dayTempLabel.text = "День /n \(model.dayTemp ?? "0")"
        nightTempLabel.text = "Ночь /n \(model.nightTemp ?? "0")"
    }
    
}
