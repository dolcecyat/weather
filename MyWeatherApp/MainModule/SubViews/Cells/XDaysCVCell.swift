//
//  WeatherInfoForXDaysCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import UIKit

class XDaysCVCell: UICollectionViewCell {
    
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
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            
            dateLabel.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 10),
            
            nightTempLabel.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor),
            nightTempLabel.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor,constant: -14),
            nightTempLabel.widthAnchor.constraint(equalToConstant: 40),
            
            
            dayTempLabel.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor),
            dayTempLabel.trailingAnchor.constraint(equalTo: nightTempLabel.leadingAnchor,constant: -14),
            dayTempLabel.widthAnchor.constraint(equalToConstant: 40),
            
            weatherImage.centerYAnchor.constraint(equalTo: cellFrame.centerYAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: dayTempLabel.leadingAnchor,constant: -14),
            weatherImage.heightAnchor.constraint(equalToConstant: 30),
            weatherImage.widthAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    private func setUI() {
        contentView.backgroundColor = UIColor(cgColor:MainColors.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: MainColors.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 10
        
        dateLabel.textColor = UIColor(cgColor: MainColors.lighterTextColor)
        dateLabel.font = .systemFont(ofSize: 14)
        
        dayTempLabel.font = .systemFont(ofSize: 14)
        dayTempLabel.textColor = UIColor(cgColor: MainColors.lighterTextColor)
        dayTempLabel.numberOfLines = 2
        dayTempLabel.textAlignment = .center
        
        nightTempLabel.font = .systemFont(ofSize: 14)
        nightTempLabel.textColor = UIColor(cgColor: MainColors.lighterTextColor)
        nightTempLabel.numberOfLines = 2
        nightTempLabel.numberOfLines = 2
        nightTempLabel.textAlignment = .center
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.conditionImage
        dateLabel.text = model.date
        dayTempLabel.text = "День \(model.dayTemp ?? "")"
        nightTempLabel.text = "Ночь \(model.nightTemp ?? "")"
    }
}
