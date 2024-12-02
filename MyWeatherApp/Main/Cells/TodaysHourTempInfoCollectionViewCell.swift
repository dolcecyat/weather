//
//  TodaysHourTempInfoCollectionViewCell.swift
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
class TodaysHourTempInfoCollectionViewCell: UICollectionViewCell {
    
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
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellFrame.widthAnchor.constraint(equalToConstant: 60),
            cellFrame.heightAnchor.constraint(equalToConstant: 60),
            
            weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 20),
            weatherImage.widthAnchor.constraint(equalToConstant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 20),
            timeLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
        
            temperatureLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = UIColor(cgColor:Constants.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: Constants.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 10
        
        timeLabel.font = .systemFont(ofSize: 10)
        timeLabel.textColor = UIColor(cgColor: Constants.timeTextColor)
        
        temperatureLabel.font = .systemFont(ofSize: 12)
        temperatureLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
        temperatureLabel.text = "0"
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.image
        timeLabel.text = model.time
        temperatureLabel.text = model.mainTemp
    }
}
