//
//  WeatherInfoView.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import SnapKit
import Then
import RxSwift

class WeatherInfoView: UIView {
    var tempLabel = UILabel()
    var weatherImageView = UIImageView()
    var highTempLabel = UILabel()
    var tempSpaceView = UIView()
    var minimumTempLabel = UILabel()
    var disposeBag = DisposeBag()
    
    convenience init() {
        self.init(frame: CGRect())
        self.addSubview(tempLabel)
        self.addSubview(weatherImageView)
        self.addSubview(tempSpaceView)
        self.addSubview(highTempLabel)
        self.addSubview(minimumTempLabel)
        
        
        /// 온도 세팅
        tempLabel.font = UIFont(name: "AppleSdGothicNeo-Medium", size: 40)
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(5)
        }
        
        /// 날씨 이미지 세팅
        weatherImageView.snp.makeConstraints {
            $0.width.height.equalTo(140)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempLabel.snp.bottom).offset(10)
        }
        
        /// 최고, 최저 온도 세팅
        tempSpaceView.backgroundColor = .clear
        tempSpaceView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(weatherImageView.snp.bottom).offset(20)
            $0.width.equalTo(15)
        }
        

        highTempLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 20)
        highTempLabel.snp.makeConstraints {
            $0.right.equalTo(tempSpaceView.snp.left)
            $0.top.equalTo(tempSpaceView.snp.top)
        }
        
        minimumTempLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 20)
        minimumTempLabel.snp.makeConstraints {
            $0.left.equalTo(tempSpaceView.snp.right)
            $0.top.equalTo(tempSpaceView.snp.top)
        }
    }
    
    func subscibe(_ viewModel: WeatherInfoViewModel) {
        viewModel.currentSubject.subscribe(onNext: { [weak self] (current, min, max) in
            self?.tempLabel.text = "\(numberFormatter.string(for: (current.temp - 273.15)) ?? "")\(tempSign)"
            self?.highTempLabel.text = "\(numberFormatter.string(for: (max - 273.15)) ?? "")\(tempSign)"
            self?.minimumTempLabel.text = "\(numberFormatter.string(for: (min - 273.15)) ?? "")\(tempSign)"
            self?.weatherImageView.image = UIImage(named: current.icon)
        })
        .disposed(by: disposeBag)
        
        viewModel.backgroundColorSubject.subscribe(onNext: { [weak self] color in
            self?.tempLabel.textColor = color == .night ? .white : .black
            self?.highTempLabel.textColor = color == .night ? .white : .black
            self?.minimumTempLabel.textColor = color == .night ? .white : .black
        })
        .disposed(by: disposeBag)
    }
}
