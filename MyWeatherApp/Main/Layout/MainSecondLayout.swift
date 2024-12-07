////
////  MainSecondLayout.swift
////  MyWeatherApp
////
////  Created by Алина Класс on 07.12.2024.
////
//
//import Foundation
//import UIKit
//
//extension MainViewController {
//    
//     func createSecondLayout() -> UICollectionViewCompositionalLayout {
//        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
//            guard let self = self else { return nil }
//            let section = SectionsData.MainFirstCollectionView.allCases.first(where: {$0.sectionNumber == sectionIndex})
//            switch section {
//            case .TodaysDetailInfo:
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
//                
//                let vStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
//                
//                let vStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),subitem: vStackItem,count: 2)
//                
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.75)), subitems: [vStackGroup])
//                
//                let section = self.createLayoutSection(group: group, behavior: .groupPaging, interGroupSpacing: 5)
//                section.contentInsets = .init(top: 0, leading: -5, bottom: 0, trailing: 0)
//                return section
//                
//            case .HourInfo:
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)), subitems: [item])
//                let section = self.createLayoutSection(group: group, behavior: .continuous, interGroupSpacing: 1)
//                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
//                return section
//            case .none:
//                return nil
//            }
//        }
//    }
//    
//    private func createLayoutSection( group: NSCollectionLayoutGroup,
//                                      behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
//                                      interGroupSpacing: CGFloat) -> NSCollectionLayoutSection {
//        let section  = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = behavior
//        section.interGroupSpacing = interGroupSpacing
//        return section
//    }
//    
//    private func createTodaysDetailInfoSection() -> NSCollectionLayoutSection {
//        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.7)), subitems: [item])
//        let section = createLayoutSection(group: group, behavior: .groupPaging, interGroupSpacing: 5)
//        section.contentInsets = .init(top: 0, leading: -5, bottom: 0, trailing: 0)
//        return section
//    }
//    
//    private func createHourInfoSection() -> NSCollectionLayoutSection {
//        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1)))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [item])
//        let section = createLayoutSection(group: group, behavior: .continuous, interGroupSpacing: 1)
//        section.contentInsets = .init(top: 0, leading: -5, bottom: 0, trailing: 0)
//        return section
//    }
//}
