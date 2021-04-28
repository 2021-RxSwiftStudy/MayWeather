//
//  AfterWeatherTodayView.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/28.
//

import UIKit

class AfterTodayWeatherView: UIView {
    
    var afterWeatherCollectionView: UICollectionView!
    
    override func draw(_ rect: CGRect) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
            $0.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            let height = SquareWeatherInfoCollectionViewCell().size.height
            $0.itemSize = CGSize(width: height * 0.6, height: height)
            $0.scrollDirection = .horizontal
            $0.invalidateLayout()
        }
        
        
        afterWeatherCollectionView = UICollectionView(frame: rect,
                                                      collectionViewLayout: layout).then {
                                                        $0.backgroundColor = .clear
                                                        $0.delegate = self
                                                        $0.dataSource = self
                                                        $0.showsHorizontalScrollIndicator = false
                                                      }
        
        afterWeatherCollectionView.register(SquareWeatherInfoCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "squareCell")
        self.addSubview(afterWeatherCollectionView)
    }
}

extension AfterTodayWeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "squareCell", for: indexPath)
            as! SquareWeatherInfoCollectionViewCell
        
        switch indexPath.item {
        case 0:
            cell.set(time: "12", icon: "sun", temp: "18")
        case 1:
            cell.set(time: "1", icon: "sun", temp: "19")
        case 2:
            cell.set(time: "2", icon: "cloud", temp: "21")
        case 3:
            cell.set(time: "3", icon: "cloud", temp: "20")
        case 4:
            cell.set(time: "4", icon: "rain", temp: "16")
        case 5:
            cell.set(time: "5", icon: "rain", temp: "16")
        case 6:
            cell.set(time: "6", icon: "cloud", temp: "15")
        case 7:
            cell.set(time: "7", icon: "moon", temp: "13")
        case 8:
            cell.set(time: "8", icon: "moon", temp: "13")
        case 9:
            cell.set(time: "9", icon: "cloud", temp: "12")
        default:
            break
        }
        
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
