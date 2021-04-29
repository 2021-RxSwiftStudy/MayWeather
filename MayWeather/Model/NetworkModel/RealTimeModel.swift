//
//  RealTimeModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation

struct RealTimeModel: Decodable {
    let baseDate: String
    let baseTime: String
    let category: String
    let nx, ny: Int
    let obsrValue: String
}
