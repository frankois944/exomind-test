//
//  OpenWeatherApi.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Moya
import Foundation

/// OpenWeather APi method
enum OpenWeatherApi {
    case getWeatherFromCity(cityName: String,
                            stateCode: String = "",
                            countryCode: String = "FR",
                            apiKey: String = ApiConstant.openWeatherApiKey)
}

// MARK: - TargetType Protocol Implementation

extension OpenWeatherApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var path: String {
        switch self {
        case .getWeatherFromCity:
            return "weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeatherFromCity:
            return Method.get
        }
    }
    
    var task: Task {
        switch self {
        case let .getWeatherFromCity(cityName, stateCode, countryCode, apiKey):
            let request = "\(cityName),\(stateCode),\(countryCode)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            return .requestParameters(parameters: ["q": request,
                                                   "apiKey": apiKey,
                                                   "units": "metric",
                                                   "lang": "fr"],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
