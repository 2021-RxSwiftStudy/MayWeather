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

    func weather(lat: Float, lon: Float, completion: @escaping (WeatherModel) -> Void) {
        rx.request(.weather(lat: lat, lon: lon))
            .map(WeatherModel.self)
            .subscribe(onSuccess: { result in
                completion(result)
            })
            .disposed(by: disposeBag)
    }
}
