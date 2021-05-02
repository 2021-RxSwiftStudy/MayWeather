//
//  BaseModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation
import Moya


enum WeatherProvider {
    // 날씨 정보
    case weather(lat: Float, lon: Float)
}

extension WeatherProvider: TargetType {
    var baseURL: URL {
        return URL(string:"https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        let result: String
        switch self {
        case .weather:
            result = "onecall"
        }
        return result
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .weather(let lat, let lon):
            let param: [String: Any] = ["appid": apiKey,
                                        "lat": lat,
                                        "lon": lon,
                                        "exclude": "minutely,alerts",
                                        "lang": "kr"]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
