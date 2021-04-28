//
//  ViewController.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    lazy var infoView = WeatherInfoView()
    lazy var scrollView = UIScrollView()
    lazy var stackView = UIStackView()
    lazy var afterTodayWeatherView = AfterTodayWeatherView()
    lazy var afterWeekWeatherView = AfterWeekWeatherView()
    lazy var topView = WeatherInfoTopView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topView)
        
        topView.snp.makeConstraints {
            if #available(iOS 11, *) {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                $0.top.equalToSuperview()
            }
            $0.left.right.equalToSuperview()
            let height = 70
            $0.height.equalTo(height)
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.addArrangedSubview(infoView)
        
        infoView.snp.makeConstraints {
            $0.height.equalTo(400)
            $0.width.equalTo(view.snp.width)
        }
        
        
        infoView.backgroundColor = .clear
        self.view.backgroundColor = .sky
        
        let lineView1 = UIView().then {
            $0.backgroundColor = .white
        }
        
        stackView.addArrangedSubview(lineView1)
        lineView1.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(1)
        }
        
        stackView.addArrangedSubview(afterTodayWeatherView)
        afterTodayWeatherView.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(SquareWeatherInfoCollectionViewCell().size.height)
        }
        afterTodayWeatherView.backgroundColor = .clear
        
        let lineView2 = UIView().then {
            $0.backgroundColor = .white
        }
        
        stackView.addArrangedSubview(lineView2)
        lineView2.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(1)
        }
        
        stackView.addArrangedSubview(afterWeekWeatherView)
        afterWeekWeatherView.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(490)
        }
        
        afterWeekWeatherView.backgroundColor = .clear
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
//
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//@available(iOS 13.0, *)
//struct MainVcRepresentble: UIViewRepresentable {
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<MainVcRepresentble>) {
//        print("updateUIView")
//    }
//
//    func makeUIView(context: Context) -> UIView { ViewController().view }
//
//}
//@available(iOS 13.0, *)
//struct MainVcPreview: PreviewProvider {
//    static var previews: some View { MainVcRepresentble() }
//}
//#endif
