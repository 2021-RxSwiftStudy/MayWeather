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
