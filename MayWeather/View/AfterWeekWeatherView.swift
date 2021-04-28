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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        tableView = UITableView(frame: frame)
        self.addSubview(tableView)
        
        tableView.register(DayWeatherTableViewCell.self, forCellReuseIdentifier: "weatherCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
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
        let count = 7
        if count * 70 != height {
            heightSubject.onNext(count)
            print("\(count) 개 보냄")
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "weatherCell")
        as! DayWeatherTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.set(date: "04/29", weekDay: "목요일", icon: "sun", high: "21", minimum: "13")
        case 1:
            cell.set(date: "04/30", weekDay: "금요일", icon: "sun", high: "24", minimum: "15")
        case 2:
            cell.set(date: "05/01", weekDay: "토요일", icon: "rain", high: "17", minimum: "10")
        case 3:
            cell.set(date: "05/02", weekDay: "일요일", icon: "cloud", high: "16", minimum: "9")
        case 4:
            cell.set(date: "05/03", weekDay: "월요일", icon: "cloud", high: "16", minimum: "11")
        case 5:
            cell.set(date: "05/04", weekDay: "화요일", icon: "sun", high: "18", minimum: "12")
        case 6:
            cell.set(date: "05/05", weekDay: "수요일", icon: "sun", high: "21", minimum: "15")
        default: break

        }
        
        cell.backgroundColor = .clear
        
        return cell
    }
}
