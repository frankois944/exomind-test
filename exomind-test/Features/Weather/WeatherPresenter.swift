//
//  WeatherPresenter.swift
//  exomind-test
//
//  Created by macartevacances on 27/09/2021.
//

import Foundation

class WeatherPresenter: WeatherPresenterContractProtocol {
    
    // MARK: - Properties
    
    var view: WeatherViewContractProtocol!
    let weatherService: WeatherServiceProtocol
    
    // MARK: - Init
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }
    
    // MARK: - Contract
    
    // MARK: - MVP attachment
    
    func attach(view: WeatherViewContractProtocol) {
        self.view = view
    }
    
    func detach() {
        self.view = nil
    }
    
    // MARK: - Cleanup
    
    deinit {
        #if DEBUG
        print("DEINIT \(self)")
        #endif
    }
    
}
