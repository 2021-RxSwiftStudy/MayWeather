//
//  AfterWeatherTodayView.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit
import RxSwift
import SnapKit

class AfterTodayWeatherView: UIView {
    var collectionView: UICollectionView!
    var disposeBag = DisposeBag()
    var list = [WeatherModel.Hourly]()
    var textColor: UIColor = .black
    
    lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "h"
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let height = SquareWeatherInfoCollectionViewCell().size.height
            $0.itemSize = CGSize(width: height * 0.6, height: height)
            $0.scrollDirection = .horizontal
            $0.invalidateLayout()
        }

        collectionView = UICollectionView(frame: frame,
                                                      collectionViewLayout: layout).then {
                                                        $0.backgroundColor = .clear
                                                        $0.delegate = self
                                                        $0.dataSource = self
                                                        $0.showsHorizontalScrollIndicator = false
                                                      }
        
        collectionView.register(SquareWeatherInfoCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "squareCell")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func subscribe(_ viewModel: WeatherInfoViewModel) {
        viewModel.todaySubject.subscribe(onNext: { [weak self] today in
            self?.list = today
            self?.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel.backgroundColorSubject.subscribe(onNext: { [weak self] color in
            self?.textColor = color == .night ? .white : .black
            self?.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }
}

extension AfterTodayWeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "squareCell", for: indexPath)
            as! SquareWeatherInfoCollectionViewCell
        
        let item = self.list[indexPath.item]
        let hour = Calendar.current.component(.hour, from: item.date)
        
        
        cell.set(time: String(hour), icon: item.icon, temp: numberFormatter.string(for: (item.temp - 273.15)) ?? "", color: textColor)
        return cell
    }
    
    
}
