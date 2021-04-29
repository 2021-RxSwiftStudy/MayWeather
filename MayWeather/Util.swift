//
//  Util.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import Foundation
import UIKit

let tempSign = " °C"

extension UILabel {
    var width: CGFloat {
        return self.intrinsicContentSize.width
    }
    
    var height: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            label.attributedText = attributedText
            label.sizeToFit()
            return label.frame.height

    }   
}

extension Date {
    static func today(hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let newDate = Calendar.current.date(bySettingHour: hour,
                                            minute: minute,
                                            second: second,
                                            of: Date())!

        return Calendar.current.date(byAdding: .hour, value: 9, to: newDate)!
    }
    
    static func kst() -> Date {
        return Calendar.current.date(byAdding: .hour, value: 9, to: Date())!
    }
    
    func addDay(value: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: value, to: self)!
    }
    
    func kst() -> Date {
        return Calendar.current.date(byAdding: .hour, value: 9, to: self)!
    }
}


extension UIColor {
    static func hex(_ hex: Int) -> UIColor {
        return UIColor(
                red: CGFloat((Float((hex & 0xff0000) >> 16)) / 255.0),
                green: CGFloat((Float((hex & 0x00ff00) >> 8)) / 255.0),
                blue: CGFloat((Float((hex & 0x0000ff) >> 0)) / 255.0),
                alpha: 1.0)

    }
    
    static var sky = UIColor.hex(0x87CEEB)
}
