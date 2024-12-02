//
//  CellsData.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 02.12.2024.
//

import Foundation

struct SectionsData {
    
    enum MainSections: CaseIterable {
        
        case TodaysDetailInfo
        case HourInfo
        case ActivityInfo
        case XDayInfo
        
        var sectionNumber: Int {
            return MainSections.allCases.firstIndex(of: self) ?? 0
        }
    }
    
    let hours = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00"]
}
