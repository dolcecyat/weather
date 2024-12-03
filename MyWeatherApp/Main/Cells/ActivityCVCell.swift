//
//  ActivityCollectionViewCell.swift
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

class ActivityCVCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var cellFrame = UIView()
    private var activityImage = UIImageView()
    private var nameLabel = UILabel()
    
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
        contentView.addSubview(activityImage)
        cellFrame.addSubview(nameLabel)
    }
    
    private func setConstraints() {
        cellFrame.translatesAutoresizingMaskIntoConstraints = false
        activityImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellFrame.widthAnchor.constraint(equalToConstant: 60),
            cellFrame.heightAnchor.constraint(equalToConstant: 60),
            
            activityImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            activityImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityImage.heightAnchor.constraint(equalToConstant: 20),
            activityImage.widthAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = UIColor(cgColor: Constants.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: Constants.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 10
        
        nameLabel.font = .systemFont(ofSize: 10)
        nameLabel.textColor = UIColor(cgColor: Constants.temperatureTextColor)
    }
    
    func configure(model: MainCellModel) {
        activityImage.image = model.activityImage
        nameLabel.text = model.activityName?.description
    }
}

