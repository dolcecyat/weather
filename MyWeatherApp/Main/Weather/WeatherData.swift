//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Анатолий Коробских on 29.11.2024.
//

import Foundation

struct WeatherData: Codable {
    let now: Int
    let nowDt: String
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case info, fact, forecasts
    }
}

// MARK: - Fact
struct Fact: Codable {
    let obsTime: Int?
    let cloudness: Double
    let condition: FactCondition
    let feelsLike, humidity: Int
    let precProb: Int
    let precStrength: Double
    let precType, pressureMm, pressurePa: Int
    let temp, uvIndex: Int?
    let windAngle: Int
    let windDir: WindDir
    let windGust, windSpeed: Double
    let source: String?
    let freshSnowMm, precMm: Double?
    let precPeriod, tempMin, tempAvg, tempMax: Int?

    enum CodingKeys: String, CodingKey {
        case obsTime = "obs_time"
        case cloudness, condition
        case feelsLike = "feels_like"
        case humidity
        case precProb = "prec_prob"
        case precStrength = "prec_strength"
        case precType = "prec_type"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case temp
        case uvIndex = "uv_index"
        case windAngle = "wind_angle"
        case windDir = "wind_dir"
        case windGust = "wind_gust"
        case windSpeed = "wind_speed"
        case source = "_source"
        case freshSnowMm = "fresh_snow_mm"
        case precMm = "prec_mm"
        case precPeriod = "prec_period"
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
    }
}

enum FactCondition: String, Codable {
    case clear = "clear"
     case partlyCloudy = "partly-cloudy"
     case cloudy = "cloudy"
     case overcast = "overcast"
     case drizzle = "drizzle"
     case lightRain = "light-rain"
     case rain = "rain"
     case moderateRain = "moderate-rain"
     case heavyRain = "heavy-rain"
     case continuousHeavyRain = "continuous-heavy-rain"
     case showers = "showers"
     case wetSnow = "wet-snow"
     case lightSnow = "light-snow"
     case snow = "snow"
     case snowShowers = "snow-showers"
     case hail = "hail"
     case thunderstorm = "thunderstorm"
     case thunderstormWithRain = "thunderstorm-with-rain"
     case thunderstormWithHail = "thunderstorm-with-hail"
}

enum Daytime: String, Codable {
    case d = "d"
    case n = "n"
}

enum WindDir: String, Codable {
    case e = "e"
    case n = "n"
    case ne = "ne"
    case nw = "nw"
    case s = "s"
    case se = "se"
    case sw = "sw"
    case w = "w"
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs: Int
    let week: Int
    let sunrise, sunset, riseBegin, setEnd: String
    let moonCode: Int
    let parts: Parts
    let moonText: String
    let hours: [Hour]


    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case week, sunrise, sunset
        case riseBegin = "rise_begin"
        case setEnd = "set_end"
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case hours, parts
    }
}
// MARK: Parts
struct Parts: Codable {
    let day: Day
    
    enum CodingKeys: String, CodingKey {
        case day
    }
}

struct Day: Codable {
    let tempMax, tempMin : Int
    let condition: FactCondition
    
    enum CodingKeys: String, CodingKey {
        
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case condition
    }
}
// MARK: - Hour
struct Hour: Codable {
    let hour: String
    let hourTs: Int
    let temp: Int
 
    enum CodingKeys: String, CodingKey {
        case hour
        case hourTs = "hour_ts"
        case temp
    }
}

enum Icon: String, Codable {
    case bknD = "bkn_d"
    case bknN = "bkn_n"
    case bknSnD = "bkn_-sn_d"
    case iconBknSnD = "bkn_+sn_d"
    case iconOvcSn = "ovc_+sn"
    case ovc = "ovc"
    case ovcSn = "ovc_-sn"
    case skcD = "skc_d"
    case skcN = "skc_n"
}

// MARK: - Info
struct Info: Codable {
    let n: Bool
    let url: String
    let lat, lon: Double
    let defPressureMm, defPressurePa, zoom: Int
    let nr, ns, nsr, p: Bool
    let f, h: Bool

    enum CodingKeys: String, CodingKey {
        case n, url, lat, lon
        case defPressureMm = "def_pressure_mm"
        case defPressurePa = "def_pressure_pa"
        case zoom, nr, ns, nsr, p, f
        case h = "_h"
    }
}
