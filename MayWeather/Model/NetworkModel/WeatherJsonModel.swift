//
//  VilageModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation
//
//struct WeatherJsonModel: Decodable {
//    let baseDate: String
//    let baseTime: String
//    let category: String
//    let fcstValue: String
//    let fcstTime: String
//    let fcstDate: String
//    let nx, ny: Int
//}

struct WeatherModel: Decodable {
    let current: Current
    let hourly: Hourly
    let daily: Daily
    
    private enum CodingKeys: String, CodingKey {
        case current
        case hourly
        case daily
    }
    struct Current: Decodable {
        var date: Date { return Date(timeIntervalSince1970: TimeInterval(dt)) }
        let sunrise: Int
        let sunset: Int
        let temp: Float
        var sky: String { return stateList[0].main }
        
        private let dt: Int
        private let stateList: [WeatherState]
    }
    struct Hourly: Decodable {
        var sky: String { return stateList[0].main }
        private let stateList: [WeatherState]
    }
    struct Daily: Decodable {
        var sky: String { return stateList[0].main }
        private let stateList: [WeatherState]
    }
}

struct WeatherState: Decodable {
    let main: String
    let icon: String
}
