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
    
    var todayWeather: TodayWeatherInfo?
    
    var disposeBag = DisposeBag()
    
    lazy var dateFormatter = DateFormatter().then {
        $0.dateFormat = "h"
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
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
        
        TodayWeatherViewModel.shared.subject.subscribe(onNext: { info in
            self.todayWeather = info
            self.collectionView.reloadData()
        })
        .disposed(by: disposeBag)
    }
}

extension AfterTodayWeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayWeather?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "squareCell", for: indexPath)
            as! SquareWeatherInfoCollectionViewCell
        
        guard let item = self.todayWeather?.list[indexPath.item] else { return cell }
        
        
        cell.set(time: self.dateFormatter.string(from: item.date),
                 icon: item.icon,
                 temp: String(item.temp))
        
        return cell
    }
    
    
}

extension AfterTodayWeatherView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
//        if section == 0 {
//                return UIEdgeInsetsMake(0, 0, 0, 1 * UIScreen.main.scale)
//            } else {
//                return UIEdgeInsets.zero
//            }
    }
}
