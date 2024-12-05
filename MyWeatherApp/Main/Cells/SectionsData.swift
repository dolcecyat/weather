//
//  CellsData.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 02.12.2024.
//

import Foundation
import UIKit

struct SectionsData {
    
    enum MainFirstCollectionView: CaseIterable {
        case TodaysDetailInfo
        case HourInfo
        
        var sectionNumber: Int {
            return MainFirstCollectionView.allCases.firstIndex(of: self) ?? 0
        }
    }
    
    enum MainSecondCollectionView: CaseIterable {
        case ActivityInfo
        case XDayInfo
        
        var sectionNumber: Int {
            return MainSecondCollectionView.allCases.firstIndex(of: self) ?? 0
        }
    }
    
    enum Activity: CaseIterable {
        case Garden
        case Water
        case Fishing
        case Winter
        case Roads
        
        var itemNumber: Int {
            return Activity.allCases.firstIndex(of: self) ?? 0
        }
        
        var image : UIImage {
            switch self {
            case .Garden:
                return UIImage(resource: .garden)
            case .Water:
                return UIImage(resource: .garden)
            case .Fishing:
                return UIImage(resource: .garden)
            case .Winter:
                return UIImage(resource: .garden)
            case .Roads:
                return UIImage(resource: .garden)
            }
        }
        
        var description: String {
            switch self {
            case .Garden:
                return "Сад и огород"
            case .Water:
                return "Водный спорт"
            case .Fishing:
                return "Рыбалка"
            case .Winter:
                return "Зимний спорт"
            case .Roads:
                return "На дорогах"
            }
        }
    }
        let hours = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00"]
}
