//
//  SquareWeatherInfoTableViewCell.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit

class SquareWeatherInfoTableViewCell: UITableViewCell {
    lazy var timeLabel = UILabel()
    lazy var statusIconImageView = UIImageView()
    lazy var tempLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        drawComponents()
    }
    
    func getSize() -> CGPoint {
        var x: CGFloat = 60
        if timeLabel.width > x { x = timeLabel.width }
        if tempLabel.width > x { x = tempLabel.width }
        var y: CGFloat = 60 + 20
        y += timeLabel.height + tempLabel.width
        
        return CGPoint(x: x, y: y)
    }
}

extension SquareWeatherInfoTableViewCell {
    func drawComponents() {
        addSubview(timeLabel)
        addSubview(statusIconImageView)
        addSubview(tempLabel)

        timeLabel.text = "00시"
        timeLabel.font = UIFont(name: "AppleSdGothicNeo-Medium", size: 20)
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        statusIconImageView.image = UIImage(named: "sun")
        statusIconImageView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        tempLabel.text = "9.7" + tempSign
        tempLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 20)
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(statusIconImageView.snp.bottom).offset(10)
        }
    }
}
