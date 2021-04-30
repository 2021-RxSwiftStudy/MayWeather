//
//  WeatherInfoTopView.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import RxSwift

class WeatherInfoTopView: UIView {
    var bookmarkButton = UIButton()
    var menuButton = UIButton()
    
    var cityNameLabel = UILabel()
    var tempStatusLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(bookmarkButton)
        self.addSubview(menuButton)
        self.addSubview(cityNameLabel)
        self.addSubview(tempStatusLabel)
        
        /// 북마크 버튼 세팅
        bookmarkButton.setImage(UIImage(named: "bookmarkOff"), for: .normal)
        bookmarkButton.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.left.top.equalToSuperview().inset(10)
        }
        
        /// 메뉴 버튼 세팅
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.right.top.equalToSuperview().inset(10)
        }
        
        /// 도시 이름 세팅
        cityNameLabel.text = "서울"
        cityNameLabel.font = UIFont(name: "AppleSdGothicNeo-Medium", size: 30)
        cityNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(3)
        }
        
        /// 요약 세팅
        tempStatusLabel.text = "맑음 ㅋ"
        tempStatusLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 20)
        tempStatusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(cityNameLabel.snp.bottom).offset(5)
        }
        
        TodayWeatherViewModel.shared.titleSubject.subscribe(onNext: { location, state in
            self.cityNameLabel.text = location
            self.tempStatusLabel.text = state
        }).disposed(by: disposeBag)
    }
}
