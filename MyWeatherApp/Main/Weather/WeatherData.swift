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
     let daytime: Daytime
     let obsTime: Int?
     let season, factSource: String?
     let uptime: Int?
     let cloudness: Double
     let condition: FactCondition
     let feelsLike, humidity: Int
     let icon: String
     let isThunder: Bool?
     let polar: Bool
     let precProb: Int
     let precStrength: Double
     let precType, pressureMm, pressurePa: Int
     let temp, uvIndex: Int?
     let windAngle: Int
     let windDir: WindDir
     let windGust, windSpeed: Double
     let source: String?
     let biomet: Biomet?
     let freshSnowMm, precMm: Double?
     let precPeriod, tempMin, tempAvg, tempMax: Int?

     enum CodingKeys: String, CodingKey {
         case daytime
         case obsTime = "obs_time"
         case season
         case factSource = "source"
         case uptime, cloudness, condition
         case feelsLike = "feels_like"
         case humidity, icon
         case isThunder = "is_thunder"
         case polar
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
         case biomet
         case freshSnowMm = "fresh_snow_mm"
         case precMm = "prec_mm"
         case precPeriod = "prec_period"
         case tempMin = "temp_min"
         case tempAvg = "temp_avg"
         case tempMax = "temp_max"
     }
 }

 // MARK: - Biomet
 struct Biomet: Codable {
     let index: Int
     let condition: BiometCondition
 }

 enum BiometCondition: String, Codable {
     case magneticField0 = "magnetic-field_0"
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
     let dateTs, week: Int
     let sunrise, sunset, riseBegin, setEnd: String
     let moonCode: Int
     let moonText: String
     let parts: Parts
     let hours: [Hour]
     let biomet: Biomet?

     enum CodingKeys: String, CodingKey {
         case date
         case dateTs = "date_ts"
         case week, sunrise, sunset
         case riseBegin = "rise_begin"
         case setEnd = "set_end"
         case moonCode = "moon_code"
         case moonText = "moon_text"
         case parts, hours, biomet
     }
 }

 // MARK: - Hour
 struct Hour: Codable {
     let hour: String
     let hourTs: Int
     let cloudness: Double
     let condition: FactCondition
     let feelsLike, humidity: Int
     let icon: String
     let precMm: Double
     let precPeriod, precProb: Int
     let precStrength: Double
     let precType, pressureMm, pressurePa, temp: Int
     let uvIndex, windAngle: Int
     let windDir: WindDir
     let windGust, windSpeed: Double

     enum CodingKeys: String, CodingKey {
         case hour
         case hourTs = "hour_ts"
         case cloudness, condition
         case feelsLike = "feels_like"
         case humidity, icon
         case precMm = "prec_mm"
         case precPeriod = "prec_period"
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
     }
 }

 // MARK: - Parts
 struct Parts: Codable {
     let day: Day
     let dayShort, evening, morning, night: Fact
     let nightShort: Fact

     enum CodingKeys: String, CodingKey {
         case day
         case dayShort = "day_short"
         case evening, morning, night
         case nightShort = "night_short"
     }
 }

 // MARK: - Day
 struct Day: Codable {
     let daytime: Daytime
     let source: String
     let biomet: Biomet?
     let cloudness: Double
     let condition: FactCondition
     let freshSnowMm, humidity: Int
     let icon: String
     let polar: Bool
     let precMm, precPeriod, precProb, precStrength: Int
     let precType, pressureMm, pressurePa, tempAvg: Int
     let tempMax, tempMin, feelsLike: Int
     let uvIndex: Int?
     let windAngle: Int
     let windDir: WindDir
     let windGust, windSpeed: Double

     enum CodingKeys: String, CodingKey {
         case daytime
         case source = "_source"
         case biomet, cloudness, condition
         case freshSnowMm = "fresh_snow_mm"
         case humidity, icon, polar
         case precMm = "prec_mm"
         case precPeriod = "prec_period"
         case precProb = "prec_prob"
         case precStrength = "prec_strength"
         case precType = "prec_type"
         case pressureMm = "pressure_mm"
         case pressurePa = "pressure_pa"
         case tempAvg = "temp_avg"
         case tempMax = "temp_max"
         case tempMin = "temp_min"
         case feelsLike = "feels_like"
         case uvIndex = "uv_index"
         case windAngle = "wind_angle"
         case windDir = "wind_dir"
         case windGust = "wind_gust"
         case windSpeed = "wind_speed"
     }
 }

 // MARK: - Info
 struct Info: Codable {
     let n: Bool
     let url: String
     let lat, lon: Double
     let tzinfo: Tzinfo
     let defPressureMm, defPressurePa, zoom: Int
     let nr, ns, nsr, p: Bool
     let f, h: Bool

     enum CodingKeys: String, CodingKey {
         case n, url, lat, lon, tzinfo
         case defPressureMm = "def_pressure_mm"
         case defPressurePa = "def_pressure_pa"
         case zoom, nr, ns, nsr, p, f
         case h = "_h"
     }
 }

 // MARK: - Tzinfo
 struct Tzinfo: Codable {
     let name, abbr: String
     let dst: Bool
     let offset: Int
 }
