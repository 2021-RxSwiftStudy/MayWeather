//
//  WeatherAPI.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation

import RxSwift
import Moya
import RxMoya


final class WeatherAPI: BaseProvider<WeatherProvider> {
    static let shared = WeatherAPI()
    
    func realTime(lat: Int, lon: Int) {
        rx.request(.realTime(x: lat, y: lon))
            .map(WeatherResult<RealTimeModel>.self)
            .subscribe(onSuccess: { result in
                print(result.list[0].baseDate, result.list[0].baseTime)
                for item in result.list {
                    print(item.category, item.obsrValue)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func weather(lat: Int, lon: Int) {
        rx.request(.vilage(x: lat, y: lon))
            .map(WeatherResult<VilageModel>.self)
            .subscribe(onSuccess: { result in
                for item in result.list {
                    print(item.fcstDate, item.fcstTime)
                    print(item.category, item.fcstValue)
                }
            })
            .disposed(by: disposeBag)
    }
}
