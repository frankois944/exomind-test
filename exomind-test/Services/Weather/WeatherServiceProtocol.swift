//
//  WeatherServiceProtocol.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Moya

protocol WeatherServiceProtocol {
    func getWeather(cityName: String, onCompletion: @escaping (Result<WeatherDataObject, Error>) -> Void) -> Cancellable
}
