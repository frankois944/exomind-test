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
    
    // MARK: - Init
    
    init() {
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
