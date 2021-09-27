//
//  WeatherServiceProtocol.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

protocol WeatherServiceProtocol {
    
    func getWeathers(citiesName: [String],
                     delay: Int,
                     onProgression: @escaping ((_ current: Int, _ total: Int) -> Void),
                     onCompletion: @escaping (Result<[WeatherDataObject], Error>) -> Void)
    
    func cancelGettingData()
}
