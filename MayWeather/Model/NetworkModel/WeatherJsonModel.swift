//
//  VilageModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation

struct WeatherJsonModel: Decodable {
    let baseDate: String
    let baseTime: String
    let category: String
    let fcstValue: String
    let fcstTime: String
    let fcstDate: String
    let nx, ny: Int
}
