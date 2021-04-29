//
//  WeatherResult.swift
//  MayWeather
//
//  Created by 오디언 on 2021/04/27.
//

import Foundation

class WeatherResult<T: Decodable>: Decodable {
    var resultCode: String = ""
    var resultMessage: String = ""
    var pageNo: Int = 0
    var totalCount: Int = 0
    var numOfRows: Int = 0
    var list: [T] = [T]()
    
    private enum CodingKeys: String, CodingKey {
        case response
    }
    
    class Response<T: Decodable>: Decodable {
        let header: Header
        var body: Body<T>?
        private enum CodingKeys: String, CodingKey {
            case header
            case body
        }
        
        class Header: Decodable {
            let resultCode: String
            let resultMessage: String
            
            private enum CodingKeys: String, CodingKey {
                case resultCode
                case resultMessage = "resultMsg"
            }
        }
        
        class Body<T: Decodable>: Decodable {
            let pageNo: Int
            let numOfRows: Int
            let totalCount: Int
            let items: Items<T>
            
            
            class Items<T: Decodable>: Decodable {
                let item: [T]
            }
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.decode(Response<T>.self, forKey: .response)
        
        self.resultCode = response.header.resultCode
        self.resultMessage = response.header.resultMessage
        
        if let body = response.body {
            self.list = body.items.item
            self.pageNo = body.pageNo
            self.numOfRows = body.numOfRows
            self.totalCount = body.totalCount
        }
    }
}
