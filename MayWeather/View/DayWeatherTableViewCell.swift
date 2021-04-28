//
//  DayWeatherTableViewCell.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import SnapKit

class DayWeatherTableViewCell: UITableViewCell {
    lazy var weekDayLabel = UILabel()
    lazy var dateLabel = UILabel()
    lazy var iconImageView = UIImageView()
    lazy var highTempLabel = UILabel()
    lazy var slashLabel = UILabel()
    lazy var minimumTempLabel = UILabel()

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        drawComponents()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        drawComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        drawComponents()
    }
    
    func set(date: String, weekDay: String, icon: String, high: String, minimum: String) {
        dateLabel.text = date
        weekDayLabel.text = weekDay
        iconImageView.image = UIImage(named: icon)
        highTempLabel.text = high + tempSign
        minimumTempLabel.text = minimum + tempSign
    }
}

extension DayWeatherTableViewCell {
    func drawComponents() {
        self.selectionStyle = .none
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(weekDayLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(highTempLabel)
        self.contentView.addSubview(slashLabel)
        self.contentView.addSubview(minimumTempLabel)
        
        weekDayLabel.text = "수요일"
        weekDayLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 15)
        weekDayLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(dateLabel.snp.right).inset(10)
        }
        
        dateLabel.text = "04/28"
        dateLabel.font = UIFont(name: "AppleSdGothicNeo-Light", size: 13)
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset((weekDayLabel.height) * -1)
            $0.left.equalToSuperview().inset(10)
        }
        
        minimumTempLabel.text = "8" + tempSign
        minimumTempLabel.font = UIFont(name: "AppleSdGothicNeo-Medium", size: 17)
        minimumTempLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(10)
        }
        
        slashLabel.text = " / "
        slashLabel.font = minimumTempLabel.font
        slashLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(minimumTempLabel.snp.left).inset(-5)
        }
        
        highTempLabel.text = "21" + tempSign
        highTempLabel.font = minimumTempLabel.font
        highTempLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(slashLabel.snp.left).inset(-5)
        }
        
        iconImageView.image = UIImage(named: "sun")
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(highTempLabel.snp.left).inset(-20)
            $0.width.height.equalTo(50)
        }
    }
}
