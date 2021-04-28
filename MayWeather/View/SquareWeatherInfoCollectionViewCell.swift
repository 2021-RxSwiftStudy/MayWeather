//
//  SquareWeatherInfoCollectionViewCell.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit

class SquareWeatherInfoCollectionViewCell: UICollectionViewCell {
    lazy var timeLabel = UILabel()
    lazy var statusIconImageView = UIImageView()
    lazy var tempLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var size: CGSize {
        var x: CGFloat = 60
        if timeLabel.width > x { x = timeLabel.width }
        if tempLabel.width > x { x = tempLabel.width }
        var y: CGFloat = 60 + 15
        y += timeLabel.height + tempLabel.width
        return CGSize(width: x, height: y)
    }
    
    func set(time: String, icon: String, temp: String) {
        timeLabel.text = time + "시"
        statusIconImageView.image = UIImage(named: icon)
        tempLabel.text = temp + tempSign
    }
}

extension SquareWeatherInfoCollectionViewCell {
    func drawComponents() {
        addSubview(timeLabel)
        addSubview(statusIconImageView)
        addSubview(tempLabel)

        timeLabel.text = "00시"
        timeLabel.font = UIFont(name: "AppleSdGothicNeo-Medium", size: 17)
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        
        statusIconImageView.image = UIImage(named: "sun")
        statusIconImageView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        tempLabel.text = "9.7" + tempSign
        tempLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 17)
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(statusIconImageView.snp.bottom).offset(10)
        }
    }
}
