//
//  AfterWeekWeatherView.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import SnapKit
import RxSwift

class AfterWeekWeatherView: UIView {
    var tableView: UITableView!
    var heightSubject = BehaviorSubject<Int>(value: 0)
    var height = 70
    var list = [WeatherModel.Daily]()
    var disposeBag = DisposeBag()
    var textColor: UIColor = .black
    lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "MM/dd"
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        tableView = UITableView(frame: frame).then {
            $0.register(DayWeatherTableViewCell.self, forCellReuseIdentifier: "weatherCell")
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
        self.addSubview(tableView)
    }
    
    func subscribe(_ viewModel: WeatherInfoViewModel) {
        viewModel.weeklySubject.subscribe(onNext: { [weak self] weekly in
            self?.list = weekly
            if weekly.count > 1 {
                self?.list.remove(at: 0)
            }
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
        viewModel.backgroundColorSubject.subscribe(onNext: { [weak self] color in
            self?.textColor = color == .night ? .white : .black
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
}

extension AfterWeekWeatherView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list.count * 70 != height {
            heightSubject.onNext(list.count)
        }
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "weatherCell")
            as! DayWeatherTableViewCell
        
        let item = list[indexPath.row]
        
        let date = dateFormatter.string(from: item.date)
        let weekDay:String
        switch Calendar.current.component(.weekday, from: item.date) {
        case 1: weekDay = "일요일"
        case 2: weekDay = "월요일"
        case 3: weekDay = "화요일"
        case 4: weekDay = "수요일"
        case 5: weekDay = "목요일"
        case 6: weekDay = "금요일"
        case 7: weekDay = "토요일"
        default: weekDay = "알 수 없음"
        }
        
        
        cell.set(date: date,
                 weekDay: weekDay,
                 icon: item.icon,
                 high: numberFormatter.string(for: (item.temp.max - 273.15)) ?? "",
                 minimum: numberFormatter.string(for: (item.temp.min - 273.15)) ?? "",
                 color: self.textColor)
        cell.backgroundColor = .clear
        
        return cell
    }
}
