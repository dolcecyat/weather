//
//  SummaryView.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 04.12.2024.
//

import Foundation
import UIKit

class SummaryView: UIView {
    
    private var viewFrame = UIView()
    private let labelButton = UIButton()
    private let button = UIButton()
    private var sumTitle = "Здесь хранится сводка о дне,неделе и выходных"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setUI()
        makeConstraints()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addViews() {
        self.addSubview(viewFrame)
        viewFrame.addSubview(labelButton)
        viewFrame.addSubview(button)
    }
    
    private func makeConstraints() {
        viewFrame.translatesAutoresizingMaskIntoConstraints = false
        labelButton.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewFrame.topAnchor.constraint(equalTo: self.topAnchor),
            viewFrame.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewFrame.widthAnchor.constraint(equalToConstant: 353),
            viewFrame.heightAnchor.constraint(equalToConstant: 110),
            
            labelButton.leadingAnchor.constraint(equalTo: viewFrame.leadingAnchor, constant: 5),
            labelButton.topAnchor.constraint(equalTo: viewFrame.topAnchor, constant: 10),
            labelButton.trailingAnchor.constraint(equalTo: viewFrame.trailingAnchor, constant: -5),
            labelButton.heightAnchor.constraint(equalToConstant: 40),
//            labelButton.widthAnchor.constraint(equalToConstant: 33),
            
            button.trailingAnchor.constraint(equalTo: viewFrame.trailingAnchor, constant: -15),
            button.leadingAnchor.constraint(equalTo: viewFrame.leadingAnchor, constant: 15),
            button.topAnchor.constraint(equalTo: labelButton.bottomAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 30),
//            button.widthAnchor.constraint(equalToConstant: 343),
    ])
    }
    
    
    private func setUI() {
        viewFrame.backgroundColor = UIColor(cgColor: Colors.lighterBackgroundColor)
        viewFrame.layer.cornerRadius = 20
        labelButton.setTitle(sumTitle, for: .normal)
        labelButton.setTitleColor(UIColor(cgColor: Colors.lighterTextColor), for: .normal)
        labelButton.backgroundColor = .clear
        labelButton.titleLabel?.font = .systemFont(ofSize: 15)
        labelButton.titleLabel?.numberOfLines = 2
        
        button.setTitle("Читать полную сводку", for: .normal)
        button.setTitleColor(UIColor(cgColor: Colors.lighterTextColor), for: .normal)
        button.backgroundColor = UIColor(cgColor: Colors.evenLighterBackgroundColor)
        button.layer.cornerRadius = 10
    }
    private func setActions() {
        labelButton.addTarget(self, action: #selector(openSummary), for: .touchUpInside)
        button.addTarget(self, action: #selector(openSummary), for: .touchUpInside)
    }
  
    @objc private func openSummary() {
        print("1")
    }
}
