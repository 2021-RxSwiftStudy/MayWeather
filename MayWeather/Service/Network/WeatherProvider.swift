//
//  BaseModel.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation
import Moya


enum WeatherProvider {
    // 동네 예보
    case vilage(x: Int, y: Int)
    // 초단기 실황
    case realTime(x: Int, y: Int)
}

extension WeatherProvider: TargetType {
    var baseURL: URL {
        return URL(string:"http://apis.data.go.kr/1360000/VilageFcstInfoService/")!
    }
    
    var path: String {
        let result: String
        switch self {
        case .vilage:
            result = "getVilageFcst"
        case .realTime:
            result = "getUltraSrtFcst"
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
        var isVilage = true
        var nx = 0
        var ny = 0
        switch self {
        case .vilage(let x, let y):
            isVilage = true
            nx = x
            ny = y
        case .realTime(let x, let y):
            isVilage = false
            nx = x
            ny = y
        }
        
        let (baseDate, baseTime) = getBaseDate(isVilage: isVilage)
        
        let param: [String: Any] = ["serviceKey": apiKey,
                     "numOfRows": 1000,
                     "pageNo": 1,
                     "dataType": "JSON",
                     "base_date": baseDate,
                     "base_time": baseTime,
                     "nx": nx,
                     "ny": ny]
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

fileprivate func getBaseDate(isVilage: Bool) -> (String, String) {
    let dateFormatter = DateFormatter()
    
    let nowTime = Date.kst()
    
    
    dateFormatter.dateFormat = "yyyyMMdd"
    var baseDate = dateFormatter.string(from: Date())
    var baseTime = "2300"
    
    if isVilage { // 동네 예보
        var timeTable = [Date]()
        var time = 2
        for _ in 0 ..< 8 {
            let date = Date.today(hour: time, minute: 5)
            timeTable.append(date)
            time += 3
        }
        
        switch nowTime {
        case timeTable[0] ..< timeTable[1]:
            baseTime = "0200"
        case timeTable[1] ..< timeTable[2]:
            baseTime = "0500"
        case timeTable[2] ..< timeTable[3]:
            baseTime = "0800"
        case timeTable[3] ..< timeTable[4]:
            baseTime = "1100"
        case timeTable[4] ..< timeTable[5]:
            baseTime = "1400"
        case timeTable[5] ..< timeTable[6]:
            baseTime = "1700"
        case timeTable[6] ..< timeTable[7]:
            baseTime = "2000"
        default:
            if timeTable[0] > nowTime {
                baseDate = dateFormatter.string(from: Date.kst().addDay(value: -1))
            }
        }
    } else { // 실황
        var hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date())
        
        if minute < 30 {
            hour -= 1
        }
        
        if hour < 0 {
            // 날짜는 하루 빼고, 시간은 23시로
            hour = 23
            baseDate = dateFormatter.string(from: Date.kst().addDay(value: -1))
        }
        
        baseTime = String(format: "%02d00", hour)
    }
    
    return (baseDate, baseTime)
}
