//
//  WeatherModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation

struct WeatherModel: Decodable {
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]
    
    public init() {
        self.current = Current()
        self.hourly = [Hourly]()
        self.daily = [Daily]()
    }
    
    private enum CodingKeys: String, CodingKey {
        case current
        case hourly
        case daily
    }
    
    struct Current: Decodable {
        let temp: Float
        var date: Date { return Date(timeIntervalSince1970: TimeInterval(timestamp)) }
        var sky: String { return stateList[0].description }
        var sunrise: Date { return Date(timeIntervalSince1970: TimeInterval(_sunrise)) }
        var sunset: Date { return Date(timeIntervalSince1970: TimeInterval(_sunset)) }
        var icon: String {
            var icon = stateList[0].icon
            if icon == "sun" {
                let hour = Calendar.current.component(.hour, from: date)
                if 6 ... 19 ~= hour {  }
                else { icon = "moon" }
            }
            
            return icon
        }
        
        private let _sunrise: Int
        private let _sunset: Int
        private let timestamp: Int
        private let stateList: [WeatherState]
        
        public init() {
            self._sunrise = 0
            self._sunset = 0
            self.temp = 0
            self.timestamp = 0
            var weather = [WeatherState]()
            weather.append(WeatherState(main: "sun", description: "알 수 없음"))
            self.stateList = weather
        }
        
        private enum CodingKeys: String, CodingKey {
            case timestamp = "dt"
            case _sunrise = "sunrise"
            case _sunset = "sunset"
            case temp = "temp"
            case stateList = "weather"
        }
    }
    
    struct Hourly: Decodable {
        let temp: Float
        var date: Date { return Date(timeIntervalSince1970: TimeInterval(timestamp)) }
        var sky: String { return stateList[0].description }
        var icon: String {
            var icon = stateList[0].icon
            if icon == "sun" {
                let hour = Calendar.current.component(.hour, from: date)
                if 6 ... 19 ~= hour {  }
                else { icon = "moon" }
            }
            
            return icon
        }
        
        private let timestamp: Int
        private let stateList: [WeatherState]
        
        public init() {
            self.temp = 0
            self.timestamp = 0
            var weather = [WeatherState]()
            weather.append(WeatherState(main: "sun", description: "알 수 없음"))
            self.stateList = weather
        }
        
        private enum CodingKeys: String, CodingKey {
            case timestamp = "dt"
            case stateList = "weather"
            case temp = "temp"
        }
    }
    
    struct Daily: Decodable {
        let temp: Temp
        var date: Date { return Date(timeIntervalSince1970: TimeInterval(timestamp)) }
        var sky: String { return stateList[0].description }
        var icon: String { return stateList[0].icon }
        var sunrise: Date { return Date(timeIntervalSince1970: TimeInterval(_sunrise)) }
        var sunset: Date { return Date(timeIntervalSince1970: TimeInterval(_sunset)) }
        
        private let _sunrise: Int
        private let _sunset: Int
        private let timestamp: Int
        private let stateList: [WeatherState]
        
        struct Temp: Decodable {
            let day: Float
            let min: Float
            let max: Float
        }
        
        private init() {
            self._sunrise = 0
            self._sunset = 0
            self.timestamp = 0
            var weather = [WeatherState]()
            weather.append(WeatherState(main: "sun", description: "알 수 없음"))
            self.stateList = weather
            self.temp = Temp(day: 0, min: 0, max: 0)
            
        }
        
        private enum CodingKeys: String, CodingKey {
            case _sunrise = "sunrise"
            case _sunset = "sunset"
            case temp = "temp"
            case timestamp = "dt"
            case stateList = "weather"
        }
    }
}

struct WeatherState: Decodable {
    let main: String
    let description: String
    var icon: String {
        var result = "sun"
        switch main {
        case "Thunderstorm": result = "cloud"
        case "Drizzle": result = "cloud"
        case "Rain": result = "rain"
        case "Snow": result = "Snow"
        case "Mist": result = "cloud"
        case "Smoke": result = "cloud"
        case "Haze": result = "cloud"
        case "Dust": result = "cloud"
        case "Fog": result = "cloud"
        case "Sand": result = "cloud"
        case "Ash": result = "cloud"
        case "Squail": result = "cloud"
        case "Tornado": result = "cloud"
        case "Clear": result = "sun"
        case "Clouds": result = "cloud"
        default: result = "sun"
        }
        
        return result
    }
}
