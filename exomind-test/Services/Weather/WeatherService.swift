//
//  WeatherService.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Moya

class WeatherService: WeatherServiceProtocol {

    func getWeather(cityName: String, onCompletion: @escaping (Result<WeatherDataObject, Error>) -> Void) -> Cancellable {
        let provider = MoyaProvider<OpenWeatherApi>()
        
        return provider.request(.getWeatherFromCity(cityName: cityName)) { moyaResult in
            switch moyaResult {
            case .success(let result):
                do {
                    let jsonObj = try result.map(GetWeatherFromCityResponse.self)
                    onCompletion(.success(.init(api: jsonObj)))
                } catch {
                    onCompletion(.failure(error))
                }
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
}
