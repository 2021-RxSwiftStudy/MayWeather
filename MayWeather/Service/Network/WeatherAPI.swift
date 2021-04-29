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
    
    func today(lat: Int, lon: Int,
               completion: @escaping ([WeatherJsonModel], [WeatherJsonModel]) -> Void) {
        let realTime = rx.request(.realTime(x: lat, y: lon))
            .map(WeatherResult<WeatherJsonModel>.self)
        
        let today = rx.request(.vilage(x: lat, y: lon))
            .map(WeatherResult<WeatherJsonModel>.self)
        Single.zip([realTime, today])
            .subscribe(onSuccess: { now in
                completion(now[0].list, now[1].list)
            })
            .disposed(by: disposeBag)
    }
}
