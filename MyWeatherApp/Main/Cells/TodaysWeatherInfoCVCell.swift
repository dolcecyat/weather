//
//  File.swift
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

class TodaysWeatherInfoCVCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    private var cellFrame = UIView()
    private var weatherImage = UIImageView()
    private var detailInfoLabel = UILabel()
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
        cellFrame.addSubview(mainInfoLabel)
        cellFrame.addSubview(detailInfoLabel)
    }
    
    private func setConstraints() {
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        mainInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        detailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            cellFrame.widthAnchor.constraint(equalToConstant: 250),
//            cellFrame.heightAnchor.constraint(equalToConstant: 150),
            
            mainInfoLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 20),
            mainInfoLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 10),
            mainInfoLabel.widthAnchor.constraint(equalToConstant: 200),
            
            
            weatherImage.topAnchor.constraint(equalTo: cellFrame.topAnchor,constant: 10),
            weatherImage.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor,constant: -10),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            weatherImage.widthAnchor.constraint(equalToConstant: 60),
            
            detailInfoLabel.bottomAnchor.constraint(equalTo: cellFrame.bottomAnchor, constant: -20),
            detailInfoLabel.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor,constant: 10),
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = .clear
        cellFrame.backgroundColor = UIColor(cgColor: Constants.lighterBackgroundColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: Constants.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 20
        
        mainInfoLabel.font = .systemFont(ofSize: 18)
        mainInfoLabel.numberOfLines = 4
        mainInfoLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
        
        detailInfoLabel.font = .systemFont(ofSize: 14)
        detailInfoLabel.textColor = UIColor(cgColor: Constants.timeTextColor)
    }
    
    func configure(model: MainCellModel) {
        weatherImage.image = model.image
        mainInfoLabel.text = model.mainInfo
        detailInfoLabel.text = model.detailInfo
    }
}

