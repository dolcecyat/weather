//
//  TodaysHourTempInfoCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import UIKit

class TodaysHourTempInfoCVCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    private var cellFrame = UIView()
    private var weatherImage = UIImageView()
    private var timeLabel = UILabel()
    private var temperatureLabel = UILabel()
    
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
        cellFrame.addSubview(timeLabel)
        cellFrame.addSubview(temperatureLabel)
    }
    
    private func setConstraints() {
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 40),
            weatherImage.widthAnchor.constraint(equalToConstant: 50),
            
            timeLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 20),
            timeLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
        
            temperatureLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = UIColor(cgColor:MainColors.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: MainColors.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 30
        
        timeLabel.font = .systemFont(ofSize: 13)
        timeLabel.textColor = UIColor(cgColor: MainColors.textColor)
        
        temperatureLabel.font = .systemFont(ofSize: 20)
        temperatureLabel.textColor = UIColor(cgColor: MainColors.lighterTextColor)
        temperatureLabel.text = ""
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.conditionImage
        timeLabel.text = model.time
        temperatureLabel.text = model.mainTemp
    }
}
