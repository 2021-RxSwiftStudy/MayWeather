//
//  BaseProvider.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation
import Alamofire
import Moya
import RxMoya
import RxSwift


/// 기본 Rx Provider 클래스
class BaseProvider<API: TargetType> {
    
    /// 기본 DisposeBag
    var disposeBag: DisposeBag = DisposeBag()
    private let provider = MoyaProvider<API>(session: DefaultAlamofireManager.shared)
    
    
    /// Rx 프로바이더
    public lazy var rx = provider.rx
    
    
    /// DisposeBag 초기화
    public func clear() {
        self.disposeBag = DisposeBag()
    }
}

fileprivate class DefaultAlamofireManager: Alamofire.Session {
    public static let shared: DefaultAlamofireManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        config.httpMaximumConnectionsPerHost = 10
        
        return DefaultAlamofireManager(configuration: config)
    }()
}
