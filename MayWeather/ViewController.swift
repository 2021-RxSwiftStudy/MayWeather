//
//  ViewController.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import SnapKit
import Then
import RxSwift

class ViewController: UIViewController {
    var infoView = WeatherInfoView()
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var afterTodayWeatherView = AfterTodayWeatherView()
    var afterWeekWeatherView = AfterWeekWeatherView()
    var topView = WeatherInfoTopView()

    var disposeBag = DisposeBag()
    
    var viewModel = WeatherInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        viewSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        afterWeekWeatherView.heightSubject.subscribe(onNext: { count in
            let height = count * 70
            if height != self.afterWeekWeatherView.height {
                self.afterWeekWeatherView.snp.updateConstraints {
                    $0.height.equalTo(height)
                }

                self.afterWeekWeatherView.tableView.snp.updateConstraints {
                    $0.edges.equalToSuperview()
                }

                self.afterWeekWeatherView.height = height
                self.afterWeekWeatherView.tableView.reloadData()
            }
        }).disposed(by: self.disposeBag)
        
        viewModel.setWeather(city: "서울시", lat: 37.413294, lon: 126.734086)
    }
}

extension ViewController {
    func viewSetup() {
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
        topView.subscribe(self.viewModel)
        
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
            $0.height.equalTo(300)
            $0.width.equalTo(view.snp.width)
        }
        infoView.backgroundColor = .clear
        infoView.subscibe(self.viewModel)
        
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
            $0.height.equalTo(140)
        }
        afterTodayWeatherView.backgroundColor = .clear
        afterTodayWeatherView.subscribe(self.viewModel)
        
        let lineView2 = UIView().then {
            $0.backgroundColor = .white
        }
        
        stackView.addArrangedSubview(lineView2)
        lineView2.snp.makeConstraints {
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(1)
        }
        
        stackView.addArrangedSubview(afterWeekWeatherView)

        afterWeekWeatherView.backgroundColor = .clear
        afterWeekWeatherView.subscribe(self.viewModel)
        
        viewModel.backgroundColorSubject.subscribe(onNext: {[weak self] color in
            self?.view.backgroundColor = color
        }).disposed(by: self.disposeBag)
    }
}
