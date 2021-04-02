//
//  ApiEndPoint.swift
//  Mobiquity Test
//
//  Created by Ram on 31/03/21.
//

import Foundation

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: String { get }
    var url: String { get }
    
    
}

enum EndPointItem {
    case getCurrentWeather
    case getFiveDaysWeather
}


extension EndPointItem: EndPointType {

    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .stage: return "http://api.openweathermap.org/data/2.5/"
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return "&appid=\(Constant.apiKey)"
        case .getFiveDaysWeather:
            return "&appid=\(Constant.apiKey)&units=metric"
        }
        
    }
    
    var httpMethod:  String{
        switch self {
        default:
            return "GET"
        }
    }
    var url: String {
        switch self {
        case .getCurrentWeather:
            return baseURL + "weather?"
        case .getFiveDaysWeather:
            return baseURL + "forecast?"
        }
        
    }
    
}
