//
//  ActivityCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation
import UIKit

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
        contentView.backgroundColor = UIColor(cgColor: Colors.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: Colors.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 10
        
        nameLabel.font = .systemFont(ofSize: 10)
        nameLabel.textColor = UIColor(cgColor: Colors.lighterTextColor)
    }
    
    func configure(model: MainCellModel) {
        activityImage.image = model.activityImage
        nameLabel.text = model.activityName?.description
    }
}

