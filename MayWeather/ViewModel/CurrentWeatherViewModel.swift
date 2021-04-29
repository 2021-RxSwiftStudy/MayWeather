//
//  CurrentWeatherViewModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/29.
//

import UIKit
import RxSwift

class CurrentWeatherViewModel {
    static let shared = CurrentWeatherViewModel()
    
    func setWeather() {
        guard let asset = NSDataAsset(name: "cityData")
        else { fatalError("도시정보 불러오기 실패") }
        
        guard let json = try? JSONDecoder().decode([CityInfo].self, from: asset.data)
        else { fatalError("도시정보 불러오기 실패") }
        let seoul = (json.filter { $0.dong == "서울특별시" })[0]
        
//        WeatherAPI.shared.realTime(lat: seoul.location.x, lon: seoul.location.y) { result in
////            print(result)
//            for item in result {
//                print(item)
//            }
//        }
    }
}
