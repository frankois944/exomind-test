//
//  WeatherContract.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

/// View contract
protocol WeatherViewContractProtocol {
    
    func weatherLoaded(items: [WeatherDataObject])
    func progressUpdated(current: Double)
    func showProgressMessage(_ message: String?)
    func showErrorMessage(_ error: Error)
}

// Presenter contract
protocol WeatherPresenterContractProtocol {
    
    var weatherItems: [WeatherDataObject] { get }
    var cities: [String] { get }
    
    func loadWeather()
    func attach(view: WeatherViewContractProtocol)
    func detach()
}
