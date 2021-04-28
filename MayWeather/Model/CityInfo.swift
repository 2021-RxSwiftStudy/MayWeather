//
//  CityInfo.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation

struct CityInfoList: Decodable {
    let list: [CityInfo]
}

struct CityInfo: Decodable {
    
    struct Location: Codable {
        let x: Int
        let y: Int
    }
    
    let city: String
    let gu: String
    let dong: String
    let location: Location
    
    
}
