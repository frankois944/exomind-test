//
//  WeatherDataObject.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Foundation

struct WeatherDataObject {
      
    let cityName: String
    let temperature: Double
    let skyIconCode: String?
    
    init(api: GetWeatherFromCityResponse) {
        cityName = api.name
        temperature = api.main.temp
        skyIconCode = api.weather.first?.icon
    }
}
