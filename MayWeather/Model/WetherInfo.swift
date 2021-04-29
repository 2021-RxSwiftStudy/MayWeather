//
//  WetherInfo.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/29.
//

import Foundation

struct TodayWeatherInfo {
    /// 시간
    let weatherDate: Date
    /// 최고 기온
    let high: Float
    /// 최저 기온
    let minimum: Float
    /// 목록
    let list: [WeatherInfo]
    /// 지금 날씨
    let now: WeatherInfo
    
    init() {
        weatherDate = Date()
        high = 0.0
        minimum = 0.0
        list = [WeatherInfo]()
        now = WeatherInfo(date: Date(), temp: 0, icon: "sun")
    }
    
    init(weathers: [WeatherJsonModel], now: [WeatherJsonModel]) {
//        self.now = WeatherInfo(date: Date(), temp: 0, icon: "sun")
        var high: Float = 0.0
        var minimum: Float = 0.0
        
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyyMMdd HHmm"
        }
        
        let sortedWeathers = weathers
            .filter { $0.category == "T3H" || $0.category == "SKY" || $0.category == "PTY" }
            .sorted { one, other in
            guard let oneDate = dateFormatter.date(from: "\(one.fcstDate) \(one.fcstTime)"),
                  let otherDate = dateFormatter.date(from: "\(other.fcstDate) \(other.fcstTime)")
            else { fatalError("날짜 변환 실패") }
            return oneDate < otherDate
        }
        
        high = Float((weathers.filter { $0.category == "TMX" }
            .sorted { one, other in
                return Float(one.fcstValue) ?? 0 > Float(one.fcstValue) ?? 0
            })[0].fcstValue) ?? 0
        
        minimum = Float((weathers.filter { $0.category == "TMN" }
            .sorted { one, other in
                return Float(one.fcstValue) ?? 0 > Float(one.fcstValue) ?? 0
            })[0].fcstValue) ?? 0
        
        self.weatherDate = dateFormatter.date(from: "\(sortedWeathers[0].fcstDate) \(sortedWeathers[0].fcstTime)")!
        self.high = high
        self.minimum = minimum
        
        var list = [WeatherInfo]()
        var i = 0
        
        while i < sortedWeathers.count {
            guard let fcstDate = dateFormatter
                    .date(from: "\(sortedWeathers[i].fcstDate) \(sortedWeathers[i].fcstTime)")
            else { fatalError("날짜 변환 실패") }
            
            let pty = Int(sortedWeathers[i].fcstValue) ?? 0
            let sky = Int(sortedWeathers[i+1].fcstValue) ?? 0
            
            let icon = setSkyStatus(fcstDate: fcstDate, pty: pty, sky: sky)
            
            list.append(WeatherInfo(date: fcstDate,
                                    temp: Float(sortedWeathers[i+2].fcstValue) ?? 0,
                                    icon: icon))
            i += 3
        }
        
        self.list = list
        
        let nowHour = String(format: "%02d00", Calendar.current.component(.hour, from: Date()))
        let nowWeather = now.filter { $0.fcstTime == nowHour }
        let nowDate = dateFormatter
                .date(from: "\(nowWeather[0].fcstDate) \(nowWeather[0].fcstTime)")
        let nowTemp = Float((now.filter { $0.category == "T1H" })[0].fcstValue) ?? 0
        let nowPty = Int((now.filter { $0.category == "PTY" })[0].fcstValue) ?? 0
        let nowSky = Int((now.filter { $0.category == "PTY" })[0].fcstValue) ?? 0
        let nowIcon = setSkyStatus(fcstDate: nowDate ?? Date(), pty: nowPty, sky: nowSky)
        self.now = WeatherInfo(date: nowDate ?? Date(),
                               temp: nowTemp,
                               icon: nowIcon)
    }
}

struct WeatherInfo {
    /// 시간
    let date: Date
    /// 온도
    let temp: Float
    /// 하늘 상태
    let icon: String
}

fileprivate func setSkyStatus(fcstDate: Date, pty: Int, sky: Int) -> String {
    var result = ""
    let hour = Calendar.current.component(.hour, from: fcstDate)
    // 해로 표시되는 시간은 오전 6시 ~ 오후 7시
    
    if 6 ... 19 ~= hour { result = "sun" }
    else { result = "moon" }
    
    // 구름이 꼈다면 구름
    if sky > 1 { result = "cloud" }
    
    // PTY코드에 따라서 1,2,4,5,6은 비
    // 3,7은 눈
    if pty == 1 || pty == 2 || pty == 4 || pty == 5 || pty == 6 { result = "rain" }
    if pty == 3 || pty == 7 { result = "snow" }
    
    return result
}
