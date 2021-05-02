//
//  WeatherInfoViewModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/29.
//

import UIKit
import RxSwift

class WeatherInfoViewModel {
    var currentSubject = BehaviorSubject<(WeatherModel.Current, Float, Float)>(value: (WeatherModel.Current(), 0, 0))
    var todaySubject = BehaviorSubject<[WeatherModel.Hourly]>(value: [WeatherModel.Hourly]())
    var weeklySubject = BehaviorSubject<[WeatherModel.Daily]>(value: [WeatherModel.Daily]())
    var cityInfoSubject = BehaviorSubject<(String, String)>(value: ("",""))
    var backgroundColorSubject = BehaviorSubject<UIColor>(value: .sky)
    
    func setWeather(city: String, lat: Float, lon: Float) {
        WeatherAPI.shared.weather(lat: lat, lon: lon) { [weak self] result in
            self?.cityInfoSubject.onNext((city, result.current.sky))
            self?.currentSubject.onNext((result.current, result.daily[0].temp.min, result.daily[0].temp.max))
            self?.todaySubject.onNext(result.hourly)
            self?.weeklySubject.onNext(result.daily)
            
            // 컬러는 이렇게 바꿈.
            let backgroundColor: UIColor
            switch result.current.icon {
            case "sky": backgroundColor = .sky
            case "snow": backgroundColor = .snow
            case "moon": backgroundColor = .night
            case "rain": backgroundColor = .rain
            case "cloud": backgroundColor = .cloud
            default: backgroundColor = .sky
            }
            self?.backgroundColorSubject.onNext(backgroundColor)
        }
    }
}
