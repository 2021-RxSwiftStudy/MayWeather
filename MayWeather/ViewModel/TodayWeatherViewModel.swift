//
//  TodayWeatherViewModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/29.
//

// 일단 서울만 테스트

import UIKit
import RxSwift

class TodayWeatherViewModel {
    static let shared = TodayWeatherViewModel()
    var subject = BehaviorSubject<TodayWeatherInfo>(value: TodayWeatherInfo())
    
    func setTodayWeatherInfo() {
        guard let asset = NSDataAsset(name: "cityData")
        else { fatalError("도시정보 불러오기 실패") }
        
        guard let json = try? JSONDecoder().decode([CityInfo].self, from: asset.data)
        else { fatalError("도시정보 불러오기 실패") }
        let seoul = json.filter { $0.dong == "서울특별시" }
        
        WeatherAPI.shared.today(lat: seoul[0].location.x, lon: seoul[0].location.y) { now, today in
            self.subject.onNext(TodayWeatherInfo(weathers: today, now: now))
        }
    }
}
