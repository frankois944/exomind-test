//
//  WeatherContract.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

/// View contract
protocol WeatherViewContractProtocol {
}

// Presenter contract
protocol WeatherPresenterContractProtocol {
    
    func attach(view: WeatherViewContractProtocol)
    func detach()
}
