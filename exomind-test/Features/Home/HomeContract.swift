//
//  HomeContract.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

/// View contract
protocol HomeViewContractProtocol {
    func navigateToWeatherScreen()
}

// Presenter contract
protocol HomePresenterContractProtocol {
    
    func goToWeather()
    
    func attach(view: HomeViewContractProtocol)
    func detach()
}
