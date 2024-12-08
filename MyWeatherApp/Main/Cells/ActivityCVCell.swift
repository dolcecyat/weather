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
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
//            cellFrame.widthAnchor.constraint(equalToConstant: 60),
//            cellFrame.heightAnchor.constraint(equalToConstant: 60),
            
            activityImage.topAnchor.constraint(equalTo: cellFrame.topAnchor,constant: 5),
            activityImage.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
            activityImage.heightAnchor.constraint(equalToConstant: 30),
            activityImage.widthAnchor.constraint(equalToConstant: 35),
            
            nameLabel.topAnchor.constraint(equalTo: activityImage.bottomAnchor, constant: 2),
            nameLabel.centerXAnchor.constraint(equalTo: cellFrame.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func setUI(){
        contentView.backgroundColor = UIColor(cgColor: Colors.backgroundViewColor)
        
        cellFrame.backgroundColor = UIColor(cgColor: Colors.lighterBackgroundColor)
        cellFrame.layer.cornerRadius = 10
        
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.textColor = UIColor(cgColor: Colors.lighterTextColor)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }
    
    func configure(model: MainCellModel) {
        activityImage.image = model.activityImage
        nameLabel.text = model.activityName?.description
    }
}

